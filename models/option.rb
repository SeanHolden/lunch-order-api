class Option
  attr_reader :text
  private :text

  def initialize(text)
    @text = text
  end

  def first
    text.split[1]
  end
end
