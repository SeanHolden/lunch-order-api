module Response
  class Order

    attr_reader :name, :text_order
    private :name, :text_order

    def initialize(name, text_order)
      @name, @text_order = name, text_order
    end

    def success
      {
        response_type: 'in_channel',
        text: "Order placed for #{name}.",
        attachments: [
          {
            text: text_order
          }
        ]
      }
    end

    def error
      {
        response_type: 'in_channel',
        text: "Oh no, something went wrong.",
        attachments: [
          {
            text: "Order for #{name} did not save to database."
          }
        ]
      }
    end

  end
end
