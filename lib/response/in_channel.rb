module Response
  class InChannel
    attr_reader :text, :secondary
    private :text, :secondary

    def initialize(text, secondary)
      @text, @secondary = text, secondary
    end

    def self.display(text, secondary)
      new(text, secondary).display
    end

    def display
      {
        response_type: 'in_channel',
        text: text,
        attachments: [
          {
            text: secondary
          }
        ]
      }
    end
  end
end
