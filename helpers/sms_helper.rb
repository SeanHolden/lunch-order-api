module SmsHelper
  def authenticate!
    return if env['HTTP_SMS_TOKEN'] == sms.config.header_token
    halt 401, json({ status: '401', message: 'Not authorized' })
  end

  def sms
    Sms.new
  end
end
