class CommandsController < ApplicationController
  helpers CommandsHelper

  before(method: :post) { slack_authenticate! }

  post '/' do
    case
    when command.cancel?
      cancel_user_orders
      json slack_response.cancel
    when command.reply? && overseer?
      reply.send_sms
      json slack_response.reply
    when command.check? && overseer?
      json slack_response.check
    else
      json place_order
    end
  end
end
