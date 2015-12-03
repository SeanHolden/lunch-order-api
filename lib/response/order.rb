module Response
  class Order

    attr_reader :name, :text_order
    private :name, :text_order

    def initialize(name, text_order)
      @name, @text_order = name, text_order
    end

    def success
      {
        message: "Order placed for #{name}.",
        order: text_order,
      }
    end

    def error
      {
        message: 'Something went wrong',
        issue: 'Order did not save to database'
      }
    end

  end
end
