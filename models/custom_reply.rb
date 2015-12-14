class CustomReply < Sms::Twilio
  attr_reader :text
  private :text

  def initialize(text)
    @text = text
  end

  def body
    text.split(' ')[1..-1].join(' ')
  end
end
