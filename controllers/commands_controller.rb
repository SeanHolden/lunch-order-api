class CommandsController < ApplicationController
  helpers OrdersHelper

  before(method: :post) { slack_authenticate! }

  post '/' do
    if command.reply?
      reply.send_sms
    elsif command.cancel?
      cancel_user_orders
    else
      place_order
    end
  end

  def cancel_user_orders
    Order.todays_orders.destroy_all(name: params[:user_name])
  end

  def reply
    CustomReply.new(params[:text])
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
end
