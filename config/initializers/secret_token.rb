# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Booksy::Application.config.secret_token = ENV['RAILS_COOKIE_SECRET']
Booksy::Application.config.secret_key_base = ENV['RAILS_COOKIE_SECRET'] 