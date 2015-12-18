class SlackResponse
  attr_reader :name, :text
  private :name, :text

  def initialize(name, text)
    @name, @text = name, text
  end

  def cancel
    Formatter.display("All orders cancelled for #{name}", '')
  end

  def reply
    Formatter.display("Reply sent:", reply_text)
  end

  def check
    Formatter.display("Orders so far:", check_text)
  end

  def menu
    Formatter::Image.display('https://files.slack.com/files-pri/T024YSFJY-F0B69QBM5/hatch.jpg')
  end

  private

  def reply_text
    CustomReply.format(text)
  end

  def check_text
    OrderPresenter.todays_orders_slack_format
  end
end
