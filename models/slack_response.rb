class SlackResponse
  attr_reader :name, :text
  private :name, :text

  def initialize(name, text)
    @name, @text = name, text
  end

  def cancel
    Formatter.display("All orders cancelled for #{name}", '')
  end

  def special_cancel
    Formatter.display("All orders cancelled for #{other_user_name}", '')
  end

  def special_cancel_failed
    Formatter.display("#{other_user_name} is not a valid username", 'No order was cancelled')
  end

  def reply
    Formatter.display("Reply sent:", reply_text)
  end

  def check
    Formatter.display("Orders so far:", check_text)
  end

  def menu
    Formatter::Image.display('http://i.imgur.com/1sos6Yu.jpg')
  end

  private

  def reply_text
    CustomReply.format(text)
  end

  def check_text
    OrderPresenter.todays_orders_slack_format
  end

  def other_user_name
    Option.new(text).first
  end
end
