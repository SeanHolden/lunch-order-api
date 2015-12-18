module CommandsHelper
  def command
    Command.new(text)
  end

  def cancel_user_orders
    Order.todays_orders.destroy_all(name: name)
  end

  def cancel_other_user_orders
    if contains_name_of_other_user?
      Order.todays_orders.destroy_all(name: options.first)
      slack_response.special_cancel
    else
      slack_response.special_cancel_failed
    end
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

  def contains_name_of_other_user?
    Order.todays_orders.pluck(:name).include?(options.first)
  end

  def options
    @options ||= Option.new(text)
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
