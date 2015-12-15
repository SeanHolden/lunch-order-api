module Request
  class SlackSmsStatus < SlackSmsReply

    private

    def payload
      {
        username: username,
        icon_url: 'http://i.imgur.com/smYKSND.png',
        text: body
      }
    end
  end
end
