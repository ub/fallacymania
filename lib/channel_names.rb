# names for interthread communication
# mix into controller
module ChannelNames
  def redisCN_playerlist_for_game( game )
    "=[#{request.port}]#{game_stream_path(game)}:players"
  end

  def redisCN_clientconnections_for_game( game )
    "=[#{request.port}]#{game_stream_path(game)}:clients"
  end

end