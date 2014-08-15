class MarqueeController < ApplicationController
  def show
    @games = Game.all
    @open_games = @games #TODO: find all open games no more than an hour old
  end
end
