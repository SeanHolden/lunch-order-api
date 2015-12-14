require './spec/spec_helper'

describe Sms do
  subject(:sms) { Sms.new }

  let(:twilio_client) { double(Sms::Twilio) }

  before { allow(Sms::Twilio).to receive(:new).and_return(twilio_client) }

  describe '#send_sms' do
    it 'calls send method on the client' do
      expect(twilio_client).to receive(:send_sms)
      sms.send_sms
    end
  end

  describe '#body' do
    let(:body) { double(Sms::Body, to_s: 'this is the text body') }

    before { allow(Sms::Body).to receive(:new).and_return(body) }

    it 'calls to_s method on body object' do
      expect(sms.body).to eql('this is the text body')
    end
  end

  describe '#client' do
    it 'creates new client' do
      expect(sms.client).to eql(twilio_client)
    end
  end
end
