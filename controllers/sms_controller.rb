class SmsController < ApplicationController
  helpers SmsHelper

  before(method: :post) { authenticate! }

  get '/' do
    if Order.any?
      sms.body
    else
      json message: 'No orders placed today'
    end
  end

  post '/' do
    if Order.any?
      response = sms.send
      json message: 'SMS sent', body: sms.body, response: response
    else
      json message: 'No orders placed today'
    end
  end

  post '/status' do
    SmsDeliveryReport.create(status: params[:status])
  end
end
