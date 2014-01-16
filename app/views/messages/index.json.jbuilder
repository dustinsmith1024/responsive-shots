json.array!(@messages) do |message|
  json.extract! message, :id, :description, :error, :token, :email, :url, :delivered
  json.url message_url(message, format: :json)
end
