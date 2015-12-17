class CommandsController < ApplicationController
  helpers CommandsHelper

  before(method: :post) { slack_authenticate! }

  post '/' do
    case
    when command.cancel?
      cancel_user_orders
      json formatted_slack_response("All orders cancelled for #{name}", '')
    when command.reply? && overseer?
      reply.send_sms
      json formatted_slack_response("Reply sent:", formatted_reply)
    when command.check? && overseer?
      json formatted_slack_response("Orders so far:", OrderPresenter.todays_orders.to_json)
    else
      json place_order
    end
  end
end
