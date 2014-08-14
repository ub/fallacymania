class MarqueeController < ApplicationController
  def show
    @games = Game.all
  end
end
