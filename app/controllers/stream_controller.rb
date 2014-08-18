class StreamController < ApplicationController
  include ActionController::Live
  def show
    logger.info params
    render nothing: true
  end
end
