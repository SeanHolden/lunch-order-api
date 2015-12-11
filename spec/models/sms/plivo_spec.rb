require './spec/spec_helper'

describe Sms::Plivo do
  subject(:sms_plivo) { Sms::Plivo.new }

  let(:rest_api) { double(::Plivo::RestAPI) }

  before do
    allow(::Plivo::RestAPI).to receive(:new).
      with('plivo_auth_id', 'plivo_auth_token').
      and_return(rest_api)
  end

  describe '#client' do
    it 'returns Plivo::RestApi object' do
      expect(sms_plivo.client).to eql(rest_api)
    end
  end

  describe '#send' do
    let(:body) { double(Sms::Body, to_s: 'sms body') }
    let(:expected_attributes) {
      {
        src: '+447987654321',
        dst: '+447123456789',
        text: 'sms body',
        url: 'http://test.com/status',
        method: 'POST',
      }
    }

    before do
      allow(Sms::Body).to receive(:new).and_return(body)
    end

    it 'calls Plivo send_message method' do
      expect(rest_api).to receive(:send_message).with(expected_attributes)
      sms_plivo.send
    end
  end
end
