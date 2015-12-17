class OrdersController < ApplicationController
  helpers OrdersHelper

  get '/' do
    json todays_orders
  end
end
