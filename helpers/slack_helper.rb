module SlackHelper
  def sms_reply
    if params[:Body]
      Request::Slack.new(params[:Body], 'The Hatch SMS Reply')
    end
  end
end
