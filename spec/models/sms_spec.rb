require './spec/spec_helper'

describe Sms do
  subject(:sms) { Sms.new }

  let(:client) { double(Sms::Client) }

  before { allow(Sms::Client).to receive(:new).and_return(client) }

  describe '#send_sms' do
    it 'calls send method on the client' do
      expect(client).to receive(:send_sms)
      sms.send_sms
    end
  end

  describe '#body' do
    let(:body) { double(Sms::Body, to_s: 'this is the text body') }

    before { allow(client).to receive(:body).and_return(body) }

    it 'calls to_s method on body object' do
      expect(sms.body).to eql('this is the text body')
    end
  end
end
