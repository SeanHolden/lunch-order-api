class CommandsController < ApplicationController
  helpers OrdersHelper, CommandsHelper

  before(method: :post) { slack_authenticate! }

  post '/' do
    if command.cancel?
      cancel_user_orders
      json formatted_slack_response("All orders cancelled for #{name}", '')
    elsif command.reply? && overseer?
      reply.send_sms
      json formatted_slack_response("Reply sent:", formatted_reply)
    else
      json place_order
    end
  end
end
