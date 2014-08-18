class StreamController < ApplicationController
  include ActionController::Live
  def show
    logger.info params
    response.headers['Content-type'] = 'text/event-stream'
    response.stream.write("event: player_joined\n")
    response.stream.write("data: Atos\n\n")
    render nothing: true
  rescue IOError
    logger.info "stream closed"
  ensure
    response.stream.close
    logger.info "DONE"
  end
end
