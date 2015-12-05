class SmsController < ApplicationController
  helpers SmsHelper

  before(method: :post) { authenticate! }

  get '/' do
    sms.body
  end

  post '/' do
    if Order.any?
      sms.send
      json message: 'SMS sent', body: sms.body
    else
      json message: 'no orders placed today'
    end
  end
end
