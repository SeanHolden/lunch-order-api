class Sms
  def send
    client.send
  end

  def body
    Body.new.to_s
  end

  def client
    Twilio.new
  end
end
