class ApplicationController < ActionController::Base
  def current_player
    @current_player ||= Player.find_by id: session[:player_id] if session[:player_id]
  end

  def current_game
    Game.current_game
  end
end
