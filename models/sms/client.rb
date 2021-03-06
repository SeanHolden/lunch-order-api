class Sms
  class Client
    attr_reader :body
    private :body

    def initialize(body)
      @body = body
    end

    def client
      ::Twilio::REST::Client.new
    end

    def send_sms
      client.messages.create(attributes)
    end

    private

    def attributes
      {
        from: ENV['SMS_FROM_NUMBER'],
        to: ENV['SMS_TO_NUMBER'],
        body: body,
        status_callback: ENV['SMS_STATUS_URL'],
      }
    end
  end
end
