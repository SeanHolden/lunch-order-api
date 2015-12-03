class SmsController < ApplicationController
  helpers SmsHelper

  get '/' do
    json message: 'testing 123'
  end
end
