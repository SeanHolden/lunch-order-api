module Response
  class Order
    attr_reader :name, :text_order
    private :name, :text_order

    def initialize(name, text_order)
      @name, @text_order = name, text_order
    end

    def success
      if on_time?
        order_placed
      else
        too_late
      end
    end

    def error
      display(
        'Oh no, something went wrong.',
        "Order for #{name} did not save."
      )
    end

    private

    def order_placed
      display(
        "Order placed for #{name}.",
        "A text will be sent at #{deadline} for:\n#{text_order}\nIt will be ready for pickup at 12pm."
      )
    end

    def too_late
      display(
        "Sorry, #{name}. Order deadline was #{deadline}. It is currently #{time}",
        "You can still text your own order with: #{to_number}"
      )
    end

    def display(text, secondary)
      InChannel.display(text, secondary)
    end

    def to_number
      ENV["SMS_TO_NUMBER"]
    end

    def on_time?
      DateTime.now < DateTime.parse("#{Date.today} #{deadline}")
    end

    def time
      Time.now.strftime("%I:%M%P")
    end

    def deadline
      '11:40am'
    end
  end
end
