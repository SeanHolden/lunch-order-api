class Sms
  class Client
    def body
      Body.new.to_s
    end

    private

    def from_number
      ENV['SMS_FROM_NUMBER']
    end

    def to_number
      ENV['SMS_TO_NUMBER']
    end
  end
end
