require './spec/spec_helper'

describe SmsHelper do
  include SmsHelper
  include FakeSmsHelper

  describe '#sms' do
    it 'returns Sms object' do
      expect(Sms).to receive(:new)
      sms
    end
  end

  describe '#config' do
    it 'returns Configuration::Sms object' do
      expect(Configuration::Sms).to receive(:new)
      config
    end
  end

  describe '#no_orders_message' do
    it 'returns appropriate hash' do
      expect(no_orders_message).to eql({ message: 'No orders placed today' })
    end
  end

  describe '#authorized?' do
    subject { authorized? }

    let(:request_object) { double('FakeRequest', path_info: path) }
    let(:path) { '/sms' }
    let(:token) { 'token' }
    let(:config) { double('Config', header_token: header_token) }
    let(:header_token) { 'token' }

    before do
      allow(FakeSmsHelper::FakeRequest).to receive(:new).and_return(request_object)
      allow(Configuration::Sms).to receive(:new).and_return(config)
      allow(ENV).to receive(:[]).with('SMS_TOKEN').and_return('token')
    end

    context 'URL is /status' do
      let(:path) { '/status' }

      it { is_expected.to eql(true) }
    end

    context 'URL is NOT /status' do
      context 'SMS token header is correct' do
        it { is_expected.to eql(true) }
      end

      context 'SMS token header is NOT correct' do
        let(:header_token) { 'invalid' }

        it { is_expected.to eql(false) }
      end
    end
  end
end
