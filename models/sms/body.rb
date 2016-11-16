class Sms
  class Body
    def to_s
      "Hello. Could I please place an order to collect around 12.\n#{order_list}\nThank you!"
    end

    private

    def order_list
      todays_orders.each_with_index.map { |order, i|
        "#{prefix(i+1)} #{order.text_order} (#{order.name})"
      }.join("\n")
    end

    def prefix(i)
      multiple_orders? ? "#{i})" : '-'
    end

    def multiple_orders?
      @multiple_orders ||= todays_orders.length > 1
    end

    def todays_orders
      @todays_orders ||= Order.todays_orders
    end
  end
end
