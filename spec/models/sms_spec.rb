require './spec/spec_helper'

describe Sms do
  subject(:sms) { Sms.new }

  let(:client) { double(Sms::Client) }
  let(:body) { double(Sms::Body, to_s: 'this is the text body') }

  before do
    allow(Sms::Body).to receive(:new).and_return(body)
    allow(Sms::Client).to receive(:new).with('this is the text body').
      and_return(client)
  end

  describe '#send_sms' do
    it 'calls send method on the client' do
      expect(client).to receive(:send_sms)
      sms.send_sms
    end
  end

  describe '#body' do
    it 'calls to_s method on body object' do
      expect(sms.body).to eql('this is the text body')
    end
  end
end
