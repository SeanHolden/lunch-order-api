class Sms
  def send_sms
    client.send_sms
  end

  def body
    client.body.to_s
  end

  private

  def client
    Client.new
  end
end
