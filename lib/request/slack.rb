module Request
  class Slack
    attr_reader :body, :username
    private :body, :username

    def initialize(body, username)
      @body, @username = body, username
    end

    def send_to_slack_channel
      connection.post do |req|
        req.headers['Content-Type'] = 'application/json'
        req.body = payload.to_json
      end
    end

    private

    def connection
      Faraday.new(url: url) do |faraday|
        faraday.response(:logger)
        faraday.adapter(Faraday.default_adapter)
      end
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
