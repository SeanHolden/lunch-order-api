module SmsHelper
  def authenticate!
    return if authorized?
    halt 401, json({ status: '401', message: 'Not authorized' })
  end

  def sms
    Sms.new
  end

  def config
    Configuration::Sms.new
  end

  def authorized?
    if request.path_info == '/status'
      true
    else
      env['HTTP_SMS_TOKEN'] == config.header_token
    end
  end
end
