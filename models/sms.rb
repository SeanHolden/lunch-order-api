class Sms
  def send
    client.messages.create(attributes)
  end

  def body
    Body.new.to_s
  end

  def config
    @config ||= Configuration::Sms.new
  end

  private

  def attributes
    {
      from: config.from_number,
      to: config.to_number,
      body: body
    }
  end

  def client
    config.client
  end
end
