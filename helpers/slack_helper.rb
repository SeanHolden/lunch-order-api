module SlackHelper
  def sms_reply
    Request::Slack.new(params[:Body], 'The Hatch SMS Reply')
  end
end
