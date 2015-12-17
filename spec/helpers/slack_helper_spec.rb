require './spec/spec_helper'

describe SlackHelper do
  include SlackHelper
  include FakeSlackHelper

  describe '#sms_reply' do
    let(:request_object) { double(Webhook::SlackSmsReply) }

    before do
      allow(Webhook::SlackSmsReply).to receive(:new).
        with('The Hatch SMS Reply', 'This is a body').
        and_return(request_object)
    end

    it 'returns request slack object' do
      expect(sms_reply).to eql(request_object)
    end
  end
end
