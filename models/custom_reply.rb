class CustomReply
  attr_reader :text
  private :text

  def initialize(text)
    @text = text
  end

  def self.format(text)
    new(text).format
  end

  def format
    text.split(' ')[1..-1].join(' ')
  end
end
