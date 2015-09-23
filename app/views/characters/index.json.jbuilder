json.array!(@characters) do |character|
  json.extract! character, :id, :game_id, :user_id
  json.url character_url(character, format: :json)
end
