class MarqueeController < ApplicationController
  before_filter :authenticate_user!
  def show
    current_game = Game.active_for current_user
    #redirect_to play_game_path(current_game) if current_game  #

    @games = Game.all
    @open_games = @games #TODO: find all open games no more than an hour old
  end
end
