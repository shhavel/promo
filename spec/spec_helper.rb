$:.unshift File.expand_path("../lib/promo")
require 'promo'

RSpec.configure do |config|
  config.mock_with :rspec
end
