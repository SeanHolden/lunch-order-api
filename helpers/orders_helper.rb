module OrdersHelper

  def order
    Order.new(name: params[:name], text_order: params[:text_order])
  end

  def order_response
    Response::Order.new(params[:name], params[:text_order])
  end

  def todays_orders
    OrderPresenter.todays_orders
  end

end
