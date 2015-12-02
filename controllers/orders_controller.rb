class OrdersController < Sinatra::Base
  include OrdersHelper

  get '/orders' do
    json all_orders
  end

  post '/orders' do
    if order.save
      json order_placed_response
    else
      json error_response
    end
  end

end
