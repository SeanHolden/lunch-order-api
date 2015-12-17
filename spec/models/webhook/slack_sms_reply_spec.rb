require './spec/spec_helper'

describe Webhook::SlackSmsReply do
  describe '#send_to_channel' do
    let(:sms_reply) {
      Webhook::SlackSmsReply.new('username', 'This is a reply')
    }
    let(:request) { double(Request) }
    let(:url) { 'test.com' }
    let(:payload) {
      {
        username: "username",
        icon_url: "http://i.imgur.com/3yy0FP8.png",
        text: "This is a reply"
      }
    }

    before do
      allow(ENV).to receive(:[]).with('SLACK_WEBHOOK_URL').and_return(url)
      allow(Request).to receive(:new).with(url, payload).and_return(request)
    end

    it 'sends post request' do
      expect(request).to receive(:post)
      sms_reply.send_to_slack_channel
    end
  end
end
