require './spec/spec_helper'

describe Sms do
  subject(:sms) { Sms.new }

  let(:plivo_client) { double(Sms::Plivo) }

  before { allow(Sms::Plivo).to receive(:new).and_return(plivo_client) }

  describe '#send' do
    it 'calls send method on the client' do
      expect(plivo_client).to receive(:send)
      sms.send
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
      expect(sms.client).to eql(plivo_client)
    end
  end
end
