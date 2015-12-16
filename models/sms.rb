class Sms
  def send_sms
    client.send_sms
  end

  def body
    Body.new.to_s
  end

  private

  def client
    Client.new(body)
  end
end
