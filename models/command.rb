class Command
  attr_reader :text
  private :text

  def initialize(text)
    @text = text
  end

  def cancel?
    command == 'cancel'
  end

  def reply?
    command == 'reply'
  end

  def check?
    command == 'check'
  end

  def menu?
    command == 'menu'
  end

  private

  def command
    text.split.first.downcase
  end
end
