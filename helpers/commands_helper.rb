module CommandsHelper
  def slack_formatted_response(response_text, secondary)
    Response::InChannel.new(response_text, secondary).display
  end

  def cancel_user_orders
    Order.todays_orders.destroy_all(name: name)
  end

  def reply
    @reply ||= CustomReply.new(text)
  end

  def command
    Command.new(text)
  end

  def place_order
    if order.save
      json order_response.success
    else
      json order_response.error
    end
  end

  def name
    params[:user_name]
  end

  def text
    params[:text]
  end
end
