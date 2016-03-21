class Sms
  class Body
    def to_s
      "Hello. Could I please place an order to collect around 1pm.\n#{order_list}\nThank you!"
    end

    private

    def order_list
      if multiple_orders?
        multiple_order_list.join("\n")
      else
        single_order
      end
    end

    def multiple_order_list
      text_orders.each_with_index.map { |order, i| "#{i+1}) #{order}" }
    end

    def single_order
      '- ' + Order.todays_orders.last.text_order
    end

    def multiple_orders?
      text_orders.length > 1
    end

    def text_orders
      @text_orders ||= Order.todays_orders.pluck(:text_order)
    end
  end
end
