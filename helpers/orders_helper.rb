module OrdersHelper

  private

  def all_orders
    todays_orders.map do |order|
      { name: order.name, order: order.text_order}
    end
  end

  def order_placed_response
    {
      message: "Order placed for #{name}.",
      order: text_order,
    }
  end

  def error_response
    {
      message: 'Something went wrong',
      issue: 'Order did not save to database'
    }
  end

  def order
    Order.new(text_order: text_order, name: name)
  end

  def text_order
    params[:text_order]
  end

  def name
    params[:name]
  end

  def todays_orders_formatted
    todays_orders.pluck(:text_order)
  end

  def todays_orders
    @todays_orders ||= Order.todays_orders
  end

end
