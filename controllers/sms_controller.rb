class SmsController < ApplicationController
  helpers SmsHelper

  before(method: :post) { authenticate! }

  get '/' do
    if Order.any?
      json({ sms_body: sms.body })
    else
      json no_orders_message
    end
  end

  post '/' do
    if Order.any?
      sms.send_sms
      json message: 'SMS sent', body: sms.body
    else
      json no_orders_message
    end
  end

  post '/status' do
    if params[:MessageStatus]
      sms_status.send_to_slack_channel
      SmsDeliveryReport.create(status: params[:MessageStatus])
    end
  end
end
