module Configuration
  class Sms
    def header_token
      ENV['SMS_TOKEN']
    end
  end
end
