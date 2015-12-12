require './spec/spec_helper'

describe SlackHelper do
  include SlackHelper
  include FakeSlackHelper

  describe '#sms_reply' do
    let(:request_object) { double(Request::Slack) }

    before do
      allow(Request::Slack).to receive(:new).
        with('This is a body').
        and_return(request_object)
    end

    it 'returns request slack object' do
      expect(sms_reply).to eql(request_object)
    end
  end
end
