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
      {
        response_type: 'in_channel',
        text: "Oh no, something went wrong.",
        attachments: [
          {
            text: "Order for #{name} did not save."
          }
        ]
      }
    end

    private

    def order_placed
      {
        response_type: 'in_channel',
        text: "Order placed for #{name}.",
        attachments: [
          {
            text: "A text will be sent at 11:30am for:\n#{text_order}"
          }
        ]
      }
    end

    def too_late
      {
        response_type: 'in_channel',
        text: "Sorry, #{name}. Order deadline was #{deadline}am. It is currently #{time}",
        attachments: [
          {
            text: "You can still text your own order with: #{to_number}"
          }
        ]
      }
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
      '11:40'
    end
  end
end
