require File.join(File.dirname(__FILE__), '..', 'config', 'boot')
require 'sinatra'
require 'rack/test'
require 'webmock/rspec'

set :environment, :test

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

WebMock.disable_net_connect!(allow_localhost: true)

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

module FakeSlackHelper
  def params
    { body: 'This is a body' }
  end
end

ENV['SMS_TO_NUMBER'] = '+447123456789'
ENV['SMS_FROM_NUMBER'] = '+447987654321'
ENV['SMS_STATUS_URL'] = 'http://test.com/status'
ENV['PLIVO_AUTH_ID'] = 'plivo_auth_id'
ENV['PLIVO_AUTH_TOKEN'] = 'plivo_auth_token'
