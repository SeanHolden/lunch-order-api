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

module FakeSmsHelper
  class FakeRequest;end

  def request
    FakeRequest.new
  end

  def env
    { 'HTTP_SMS_TOKEN' => token }
  end
end

ENV['SMS_TO_NUMBER'] = '+447123456789'
