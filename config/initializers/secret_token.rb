# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
InstallRails::Application.config.secret_key_base = ENV['SECRET_KEY_BASE'] || "868fd6b774842ed10a3eadb9fc684b6f1172809cd6c37ef4f76044ee3e788b1d7eb5114484b94b30f01aa33fa7026a346c483d011a1d5a201a6201695a98cb6c"