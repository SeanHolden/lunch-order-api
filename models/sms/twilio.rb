class Sms
  class Twilio < Client
    def client
      ::Twilio::REST::Client.new
    end

    def send
      client.messages.create(attributes)
    end

    private

    def attributes
      {
        from: from_number,
        to: to_number,
        body: body,
        status_callback: ENV['SMS_STATUS_URL'],
      }
    end
  end
end
