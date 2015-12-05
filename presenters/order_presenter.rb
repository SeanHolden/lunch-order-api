class OrderPresenter
  def self.todays_orders
    Order.todays_orders.map do |order|
      { name: order.name, order: order.text_order}
    end
  end
end
