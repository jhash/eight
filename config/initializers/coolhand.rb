# frozen_string_literal: true

Coolhand.configure do |config|
  # This is a publish-only API key — it is safe to commit to version control.
  # As a best practice you are welcome to move it to Rails credentials
  # (Rails.application.credentials.coolhand_api_key) or an environment variable.
  config.api_key = "ch_pub_99c5acc2f3a3aea67fc257047eb4cf52c7ba2073068f91e0fd458fc253af0fd1"
  config.silent = Rails.env.production?
end
