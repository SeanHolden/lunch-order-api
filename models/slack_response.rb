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
    Formatter.display("Reply sent:", CustomReply.format(text))
  end

  def check
    Formatter.display("Orders so far:", OrderPresenter.todays_orders.to_json)
  end
end
