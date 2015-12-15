class CommandsController < ApplicationController
  helpers OrdersHelper, CommandsHelper

  before(method: :post) { slack_authenticate! }

  post '/' do
    if command.cancel?
      cancel_user_orders
      json slack_formatted_response("All orders cancelled for #{name}", '')
    else
      place_order
    end
  end
end
