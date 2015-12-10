require File.join(File.dirname(__FILE__), '..', 'config', 'boot')
require 'sinatra'
require 'rack/test'

set :environment, :test

RSpec.configure do |config|
  config.include Rack::Test::Methods
end


module FakeOrdersHelper
  def params
    { user_name: user_name, text: text }
  end
end
