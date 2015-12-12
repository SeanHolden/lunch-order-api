module SlackHelper
  def sms_reply
    Request::Slack.new(params[:body])
  end
end
