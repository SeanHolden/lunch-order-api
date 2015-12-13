module SlackHelper
  def sms_reply
    if params[:Body]
      Request::Slack.new(params[:Body])
    end
  end
end
