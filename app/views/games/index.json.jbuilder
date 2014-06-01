json.array!(@games) do |game|
  json.extract! game, :id, :description
  json.url game_url(game, format: :json)
end
