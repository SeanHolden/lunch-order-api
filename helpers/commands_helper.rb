module CommandsHelper
  def formatted_slack_response(response_text, secondary)
    Response::InChannel.new(response_text, secondary).display
  end

  def overseer?
    Overseer.pluck(:user_id).include?(user_id)
  end

  def cancel_user_orders
    Order.todays_orders.destroy_all(name: name)
  end

  def reply
    Sms::Client.new(formatted_reply)
  end

  def formatted_reply
    CustomReply.format(text)
  end

  def command
    Command.new(text)
  end

  def place_order
    if order.save
      order_response.success
    else
      order_response.error
    end
  end

  def name
    params[:user_name]
  end

  def user_id
    params[:user_id]
  end

  def text
    params[:text]
  end
end
