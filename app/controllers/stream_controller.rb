class StreamController < ApplicationController
  include ActionController::Live
  include ChannelNames
  def show
    logger.info params
    logger.info request.url # => http://localhost:3000/games/3/stream

    if ! Rails.application.config.cache_classes
      render nothing: true
      return
    end

    response.headers['Content-Type'] = 'text/event-stream'
    sse = SSE.new(response.stream,  event: "player-joined", retry: 400)

    logger.debug response.stream.class.to_s

    response.stream.on_error do
      logger.error "ERROR-" * 30
    end

    #sse.write( {nick: 'Athos', created_at: DateTime.now})
    #sleep 3
    #sse.write( {nick: 'Porthos', created_at: DateTime.now})
    #sleep 3
    #sse.write( {nick: 'Aramis', created_at: DateTime.now}, event: "message")

    e = env
    redis = nil
    redis = Redis.new
    players_data_channel = redisCN_playerlist_for_game(params[:game_id])
    browser_channel = redisCN_clientconnections_for_game(params[:game_id])
    logger.info "REDIS Channel name:" + players_data_channel
    ok=redis.publish(browser_channel,"begin")

    redis.subscribe(players_data_channel, browser_channel) do | on |
      on.message do | channel, message |
        logger.info "SUBSCRIPTION EVENT RECEIVED"
        case channel
        when players_data_channel
          begin
            logger.info "MESSAGE:" + message
            sse.write(message)
            logger.info "message written"
          rescue
            logger.error "ERROR sse.write"
            redis.unsubscribe
          end
        else
          begin
            response.stream.write(":\n\n")
          rescue
            logger.info "UNSUBSCRIBING"
            redis.unsubscribe
          end
        end
      end
      on.unsubscribe do |x|
        logger.info "unsubscribing from:" + x.to_s
      end

    end
    logger.info "ABOUT TO RENDER NOTHING HEHEHE"
    render nothing: true
  rescue IOError
    logger.info "stream closed"
  ensure
    response.stream.close
    logger.info "STREAM CLOSED"
    redis.quit if redis
    logger.info "DONE"
  end

  def destroy
    logger.info "Destroying stream connection"
    redis = Redis.new
    browser_channel = redisCN_clientconnections_for_game(params[:game_id])
    ok=redis.publish(browser_channel,"end")
    render nothing: true
  end
end
