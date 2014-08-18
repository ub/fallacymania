class StreamController < ApplicationController
  include ActionController::Live
  def show
    logger.info params
    logger.info request.url # => http://localhost:3000/games/3/stream
    response.headers['Content-Type'] = 'text/event-stream'
    sse = SSE.new(response.stream,  event: "player-joined")

    sse.write( {nick: 'Athos', created_at: DateTime.now})
    sleep 3
    sse.write( {nick: 'Porthos', created_at: DateTime.now})
    sleep 3
    sse.write( {nick: 'Aramis', created_at: DateTime.now}, event: "message")

    redis = nil
    #redis = Redis.new
    #channel_name = "-#{request.url}-"
    #redis.subscribe(channel_name) do | on |
    #  on.message do | channel, message |
    #    sse.write(message)
    #  end
    #end

    render nothing: true
  rescue IOError
    logger.info "stream closed"
  ensure
    response.stream.close
    logger.info "STREAM CLOSED"
    redis.quit if redis
    logger.info "DONE"
  end
end
