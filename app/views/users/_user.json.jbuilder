json.extract! user, :id, :name, :email, :otp_secret_key, :created_at, :updated_at
json.url user_url(user, format: :json)
