require './spec/spec_helper'

describe CustomReply do
  let(:custom_reply) { CustomReply.new('reply this is a custom reply') }

  describe 'send_sms' do
    let(:twilio_client) { double(::Twilio::REST::Client) }
    let(:messages) { double('Messages') }
    let(:expected_attributes) {
      {
        from: "+447987654321",
        to: "+447123456789",
        body: "this is a custom reply",
        status_callback: "http://test.com/status"
      }
    }

    before do
      allow(::Twilio::REST::Client).to receive(:new).and_return(twilio_client)
      allow(twilio_client).to receive(:messages).and_return(messages)
    end

    it 'sends custom text' do
      expect(messages).to receive(:create).with(expected_attributes)
      custom_reply.send_sms
    end
  end
end
