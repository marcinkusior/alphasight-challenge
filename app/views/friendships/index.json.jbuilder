json.array!(@friendships) do |friendship|
  json.extract! friendship, :id, :friender_id, :friended_id
  json.url friendship_url(friendship, format: :json)
end
