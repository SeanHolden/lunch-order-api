class SlackResponse
  class Formatter
    class Image
      attr_reader :url
      private :url

      def initialize(url)
        @url = url
      end

      def self.display(url)
        new(url).display
      end

      def display
        {
          text: '',
          attachments: [
            {
              fallback: 'Menu',
              image_url: url,
            }
          ]
        }
      end
    end
  end
end
