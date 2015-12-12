module Request
  class Slack
    attr_reader :body
    private :body

    def initialize(body)
      @body = body
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
        username: 'The Hatch SMS Reply',
        icon_url: 'http://i.imgur.com/3yy0FP8.png',
        text: body
      }
    end

    def url
      ENV['SLACK_WEBHOOK_URL']
    end
  end
end
