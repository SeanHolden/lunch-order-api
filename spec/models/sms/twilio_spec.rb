require './spec/spec_helper'

describe Sms::Twilio do
  subject(:sms_twilio) { Sms::Twilio.new }

  let(:twilio_object) { double(::Twilio::REST::Client, messages: msg_object) }
  let(:msg_object) { double('Messages') }

  before do
    allow(::Twilio::REST::Client).to receive(:new).and_return(twilio_object)
  end

  describe '#client' do
    it 'returns Twilio object' do
      expect(sms_twilio.client).to eql(twilio_object)
    end
  end

  describe '#send' do
    let(:body) { double(Sms::Body, to_s: 'sms body') }
    let(:expected_attributes) {
      {
        from: '+447987654321',
        to: '+447123456789',
        body: 'sms body',
        status_callback: 'http://test.com/status',
      }
    }

    before do
      allow(Sms::Body).to receive(:new).and_return(body)
    end

    it 'calls Twilio create method' do
      expect(msg_object).to receive(:create).with(expected_attributes)
      sms_twilio.send
    end
  end
end
