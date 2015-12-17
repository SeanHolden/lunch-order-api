module SlackHelper
  def sms_reply
    Webhook::SlackSmsReply.new('The Hatch SMS Reply', params[:Body])
  end
end
