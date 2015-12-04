class SmsController < ApplicationController
  helpers SmsHelper

  before(method: :post) { authenticate! }

  get '/' do
    json message: 'testing 123'
  end

  post '/' do
    send_sms
  end
end
