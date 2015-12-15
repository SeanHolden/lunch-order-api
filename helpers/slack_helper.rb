module SlackHelper
  def sms_reply
    Request::SlackSmsReply.new(params[:Body], 'The Hatch SMS Reply')
  end
end
