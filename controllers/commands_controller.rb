class CommandsController < ApplicationController
  helpers OrdersHelper

  before(method: :post) { slack_authenticate! }

  post '/' do
    if command.reply?
      reply.send_sms
      json slack_formatted_response("Reply was sent", reply.body)
    elsif command.cancel?
      cancel_user_orders
      json slack_formatted_response("Order cancelled for #{name}", '')
    else
      place_order
    end
  end

  def slack_formatted_response(response_text, secondary)
    Response::InChannel.new(response_text, secondary).display
  end

  def cancel_user_orders
    Order.todays_orders.destroy_all(name: name)
  end

  def reply
    @reply ||= CustomReply.new(params[:text])
  end

  def command
    Command.new(params[:text])
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
end
