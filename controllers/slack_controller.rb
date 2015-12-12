class SlackController < ApplicationController
  helpers SlackHelper

  post '/' do
    sms_reply.send_to_slack_channel
    json({ message: 'OK' })
  end
end
