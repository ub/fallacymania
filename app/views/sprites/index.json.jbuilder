json.array!(@sprites) do |sprite|
  json.extract! sprite, :id
  json.url sprite_url(sprite, format: :json)
end
