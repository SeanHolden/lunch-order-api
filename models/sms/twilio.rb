class Sms
  class Twilio < Client
    def client
      ::Twilio::REST::Client.new
    end

    def send
      client.messages.create(attributes)
    end

    def attributes
      {
        from: from_number,
        to: to_number,
        body: body,
      }
    end
  end
end
