require 'devise'

RSpec.configure do |config|
  # For controller specs
  config.include Devise::Test::IntegrationHelpers
  config.include Warden::Test::Helpers
end
