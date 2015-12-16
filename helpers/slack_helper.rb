module SlackHelper
  def sms_reply
    Webhook::SlackSmsReply.new(params[:Body], 'The Hatch SMS Reply')
  end
end
