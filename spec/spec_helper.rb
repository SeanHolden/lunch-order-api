require './config/boot'
require 'sinatra'
require 'rack/test'
require 'webmock/rspec'
require './spec/support/fake_helpers'

set :environment, :test

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

WebMock.disable_net_connect!(allow_localhost: true)
