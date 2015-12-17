require './spec/spec_helper'

describe SlackController do
  describe 'POST /slack' do
    let(:url) { 'test.com' }
    let(:sms_reply) { double(Webhook::SlackSmsReply) }
    let(:payload) {
      {
        username: 'The Hatch SMS Reply',
        icon_url: 'http://i.imgur.com/3yy0FP8.png',
        text: 'This is a reply'
      }
    }

    before do
      allow(ENV).to receive(:[]).with('SLACK_WEBHOOK_URL').and_return(url)
      allow(Webhook::SlackSmsReply).to receive(:new).
        with('The Hatch SMS Reply', 'This is a reply').and_return(sms_reply)
      allow(sms_reply).to receive(:send_to_slack_channel)
    end

    it 'returns status of 200' do
      post '/', { Body: 'This is a reply' }
      expect(last_response.status).to eql(200)
    end

    it 'returns xml response' do
      post '/', Body: 'This is a reply'
      expect(last_response.body).to eql(
        "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Response></Response>"
      )
    end
  end

  def app;SlackController;end
end
