require "bundler"
Bundler.require :default, :development

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
