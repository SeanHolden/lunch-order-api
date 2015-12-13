class SmsController < ApplicationController
  helpers SmsHelper

  before(method: :post) { authenticate! }

  get '/' do
    if Order.any?
      sms.body
    else
      json no_orders_message
    end
  end

  post '/' do
    if Order.any?
      sms.send
      json message: 'SMS sent', body: sms.body
    else
      json no_orders_message
    end
  end

  post '/status' do
    SmsDeliveryReport.create(status: params[:status])
  end
end
