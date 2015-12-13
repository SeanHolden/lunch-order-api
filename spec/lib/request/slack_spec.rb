require './spec/spec_helper'

describe Request::Slack do
  let(:webhook_url) { ENV['SLACK_WEBHOOK_URL'] }

  describe '#send_to_channel' do
    let(:slack) { Request::Slack.new('This is a reply', 'username') }
    let(:faraday) { double(Faraday) }

    before do
      allow(Faraday).to receive(:new).
        with(url: webhook_url).and_return(faraday)
    end

    it 'sends post request' do
      expect(faraday).to receive(:post)
      slack.send_to_slack_channel
    end
  end
end
