class OrderPresenter

  def self.all_orders
    Order.todays_orders.map do |order|
      { name: order.name, order: order.text_order}
    end
  end

end
