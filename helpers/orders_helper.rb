module OrdersHelper
  def order
    Order.new(name: params[:user_name], text_order: params[:text])
  end

  def order_response
    Response::Order.new(params[:name], params[:text_order])
  end

  def todays_orders
    OrderPresenter.todays_orders
  end
end
