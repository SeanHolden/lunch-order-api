module CommandsHelper
  def command
    Command.new(text)
  end

  def cancel_user_orders
    Order.todays_orders.destroy_all(name: name)
  end

  def slack_response
    SlackResponse.new(name, text)
  end

  def overseer?
    Overseer.pluck(:user_id).include?(user_id)
  end

  def reply
    Sms::Client.new(formatted_reply)
  end

  def place_order
    if order.save
      order_response.success
    else
      order_response.error
    end
  end

  private

  def order
    Order.new(name: name, text_order: text)
  end

  def order_response
    SlackResponse::Order.new(name, text)
  end

  def formatted_reply
    CustomReply.format(text)
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
