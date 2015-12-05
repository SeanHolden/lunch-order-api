module Configuration
  class Sms
    def client
      Twilio::REST::Client.new
    end

    def from_number
      ENV['SMS_FROM_NUMBER']
    end

    def to_number
      ENV['SMS_TO_NUMBER']
    end

    def header_token
      ENV['SMS_TOKEN']
    end
  end
end
