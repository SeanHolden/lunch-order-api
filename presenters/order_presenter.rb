class OrderPresenter
  def self.todays_orders
    Order.todays_orders.map do |order|
      { name: order.name, order: order.text_order}
    end
  end

  def self.todays_orders_slack_format
    Order.todays_orders.map do |order|
      "#{order.name}: #{order.text_order}"
    end.join("\n")
  end
end
