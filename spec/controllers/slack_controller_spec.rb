require './spec/spec_helper'

describe SlackController do
  describe 'POST /slack' do
    let(:payload) {
      {
        username: 'The Hatch SMS Reply',
        icon_url: 'http://i.imgur.com/3yy0FP8.png',
        text: 'This is a reply'
      }
    }

    before do
      stub_request(:post, ENV['SLACK_WEBHOOK_URL']).
        with(
          body: payload,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it 'returns status of 200' do
      post '/', Body: 'This is a reply'
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
