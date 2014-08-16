class MarqueeController < ApplicationController
  before_filter :authenticate_user!
  def show
    current_game = Game.active_for current_user
    logger.info "Current game: #{current_game.to_s}"

    @games = Game.all
    @open_games = @games #TODO: find all open games no more than an hour old
  end
end
