module SmsHelper
  def authenticate!
    return if authorized?
    halt 401, json({ status: '401', message: 'Not authorized' })
  end

  def sms
    Sms.new
  end

  def no_orders_message
   { message: 'No orders placed today' }
  end

  def sms_status
    Webhook::SlackSmsStatus.new(params[:MessageStatus], 'The Hatch SMS Status')
  end

  def authorized?
    if request.path_info == '/status'
      true
    else
      params[:token] == ENV['SMS_TOKEN']
    end
  end
end
