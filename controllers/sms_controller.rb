class SmsController < ApplicationController
  helpers SmsHelper

  before(method: :post) { authenticate! }

  get '/' do
    sms.body
  end

  post '/' do
    if Order.any?
      response = sms.send
      json message: 'SMS sent', body: sms.body, response: response
    else
      json message: 'no orders placed today'
    end
  end

  post '/status' do
    # save status in DB in a new "reports" table
  end
end
