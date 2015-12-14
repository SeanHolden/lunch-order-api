class CommandsController < ApplicationController
  helpers OrdersHelper, CommandsHelper

  before(method: :post) { slack_authenticate! }

  post '/' do
    if command.reply?
      reply.send_sms
      json slack_formatted_response("Sending Reply...", reply.body)
    elsif command.cancel?
      cancel_user_orders
      json slack_formatted_response("All orders cancelled for #{name}", '')
    else
      place_order
    end
  end
end
