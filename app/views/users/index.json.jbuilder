json.array!(@users) do |user|
  json.extract! user, :id, :first_name, :last_name, :birthday, :email, :joined_date, :rating, :phone
  json.url user_url(user, format: :json)
end
