module Webhook
  class SlackSmsReply
    attr_reader :username, :body
    private :username, :body

    def initialize(username, body)
      @username, @body = username, body
    end

    def send_to_slack_channel
      request.post
    end

    private

    def request
      Request.new(url, payload)
    end

    def payload
      {
        username: username,
        icon_url: 'http://i.imgur.com/3yy0FP8.png',
        text: body
      }
    end

    def url
      ENV['SLACK_WEBHOOK_URL']
    end
  end
end
