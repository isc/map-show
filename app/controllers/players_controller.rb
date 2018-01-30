class PlayersController < ApplicationController
  def create
    player_count = Player.count
    team = 
      if player_count.zero?
        0
      elsif player_count == 1
        1
      else
        Player.group(:team).count.to_a.min_by(&:last).first
      end
    player = Player.create! params.permit(:name).merge(team: team)
    session[:player_id] = player.id
    cookies[:player_name] = player.name
    ActionCable.server.broadcast('game', event: 'new_player', player: player)
    redirect_to '/'
  end
end
