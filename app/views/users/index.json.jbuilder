json.array!(@users) do |user|
  json.extract! user, :id, :name, :website_short, :short_url
  json.url user_url(user, format: :json)
end
