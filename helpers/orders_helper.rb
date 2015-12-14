module OrdersHelper
  def order
    Order.new(name: name, text_order: text_order)
  end

  def order_response
    Response::Order.new(name, text_order)
  end

  def todays_orders
    OrderPresenter.todays_orders
  end

  private

  def name
    params[:user_name]
  end

  def text_order
    params[:text]
  end
end
