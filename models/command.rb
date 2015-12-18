class Command
  attr_reader :text
  private :text

  def initialize(text)
    @text = text
  end

  def cancel?
    command == 'cancel'
  end

  def special_cancel?
    command == 'cancel' && contains_options?
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

  def contains_options?
    text.split.length > 1
  end

  def command
    text.split.first.downcase
  end
end
