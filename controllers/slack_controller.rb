class SlackController < ApplicationController
  helpers SlackHelper

  post '/' do
    content_type 'text/xml'

    if params[:Body]
      sms_reply.send_to_slack_channel
      '<?xml version="1.0" encoding="UTF-8"?><Response></Response>'
    end
  end
end
