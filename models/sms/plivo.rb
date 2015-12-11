class Sms
  class Plivo < Client
    def client
      ::Plivo::RestAPI.new(auth_id, auth_token)
    end

    def send
      client.send_message(attributes)
    end

    private

    def attributes
      {
        src: from_number,
        dst: to_number,
        text: body,
        url: status_url,
        method: 'POST',
      }
    end

    def status_url
      ENV['SMS_STATUS_URL']
    end

    def auth_id
      ENV['PLIVO_AUTH_ID']
    end

    def auth_token
      ENV['PLIVO_AUTH_TOKEN']
    end
  end
end
