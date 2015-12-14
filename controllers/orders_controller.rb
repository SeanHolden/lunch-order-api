class OrdersController < ApplicationController
  helpers OrdersHelper

  before(method: :post) { slack_authenticate! }

  get '/' do
    json todays_orders
  end

  post '/' do
    if order.save
      json order_response.success
    else
      json order_response.error
    end
  end
end
