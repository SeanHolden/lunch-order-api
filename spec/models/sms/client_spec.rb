require './spec/spec_helper'

describe Sms::Client do
  subject(:client) { Sms::Client.new }

  let(:body) { double(Sms::Body, to_s: 'sms body') }
  let(:twilio_object) { double(::Twilio::REST::Client, messages: msg_object) }
  let(:msg_object) { double }

  before do
    allow(::Twilio::REST::Client).to receive(:new).and_return(twilio_object)
    allow(Sms::Body).to receive(:new).and_return(body)
  end

  describe '#body' do
    it 'returns SMS body' do
      expect(body).to receive(:to_s)
      Sms::Client.new.body
    end
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

    it 'calls Twilio create method' do
      expect(msg_object).to receive(:create).with(expected_attributes)
      client.send_sms
    end
  end
end
