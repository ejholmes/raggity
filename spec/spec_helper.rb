require 'bundler'
Bundler.require :default, :development
require 'rack/test'

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
