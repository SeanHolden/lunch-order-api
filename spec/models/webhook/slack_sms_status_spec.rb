require './spec/spec_helper'

describe Webhook::SlackSmsStatus do
  describe '#send_to_channel' do
    let(:slack) { Webhook::SlackSmsStatus.new('This is a reply', 'username') }
    let(:faraday) { double(Faraday) }

    before do
      allow(Faraday).to receive(:new).
        with(url: ENV['SLACK_WEBHOOK_URL']).and_return(faraday)
    end

    it 'sends post request' do
      expect(faraday).to receive(:post)
      slack.send_to_slack_channel
    end
  end
end
