class Sms
  def send_sms
    client.send_sms
  end

  def body
    Client.new.body
  end

  def client
    Twilio.new
  end
end
