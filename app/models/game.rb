class Game < ApplicationRecord
  def self.country_list
    @country_list ||= JSON.parse File.read(Rails.root.join('public', 'countries.json'))
  end

  def in_progress?
    state == 'in_progress'
  end
  
  def self.current_game
    game = where.not(state: 'ended').first
    if game && game.updated_at < 15.minutes.ago
      Player.delete_all
      game.update! state: 'ended'
      game = nil
    end
    game || create(state: 'lobby', discovered_countries: [])
  end

  def evaluate value, player
    country = self.class.country_list.detect { |c| c[4].parameterize == value.parameterize }
    return :no_match unless country
    return :already_found if discovered_countries.find {|c| c.first == country[2]}
    discovered_countries.push [country[2], player.team]
    save
    :match
  end
end
