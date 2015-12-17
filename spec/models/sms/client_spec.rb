require './spec/spec_helper'

describe Sms::Client do
  subject(:client) { Sms::Client.new('sms body') }

  let(:twilio_object) { double(::Twilio::REST::Client, messages: msg_object) }
  let(:msg_object) { double }

  before do
    allow(::Twilio::REST::Client).to receive(:new).and_return(twilio_object)
  end

  describe '#client' do
    it 'returns Twilio object' do
      expect(client.client).to eql(twilio_object)
    end
  end

  describe '#send_sms' do
    let(:expected_attributes) {
      {
        from: '+447987654321',
        to: '+447123456789',
        body: 'sms body',
        status_callback: 'http://test.com/status',
      }
    }

    before do
      allow(ENV).to receive(:[]).with('SMS_TO_NUMBER').
        and_return('+447123456789')
      allow(ENV).to receive(:[]).with('SMS_FROM_NUMBER').
        and_return('+447987654321')
      allow(ENV).to receive(:[]).with('SMS_STATUS_URL').
        and_return('http://test.com/status')
    end

    it 'calls Twilio create method' do
      expect(msg_object).to receive(:create).with(expected_attributes)
      client.send_sms
    end
  end
end
