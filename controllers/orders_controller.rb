class OrdersController < Sinatra::Base
  include Controllers::Helpers

  get '/orders' do
    json OrderPresenter.all_orders
  end

  post '/orders' do
    if order.save
      json order_response.success
    else
      json order_response.error
    end
  end

end
