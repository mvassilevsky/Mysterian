json.array!(@games) do |game|
  json.extract! game, :id, :owner_id
  json.url game_url(game, format: :json)
end
