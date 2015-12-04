module SmsHelper
  def authenticate!
    return if env['HTTP_SMS_TOKEN'] == ENV['SMS_TOKEN']
    halt 401, "Not authorized\n"
  end

  def send_sms
    'send sms here'
  end
end
