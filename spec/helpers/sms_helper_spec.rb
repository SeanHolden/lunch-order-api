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

  describe '#no_orders_message' do
    it 'returns appropriate hash' do
      expect(no_orders_message).to eql({ message: 'No orders placed today' })
    end
  end

  describe '#sms_status' do
    let(:request_object) { double(Webhook::SlackSmsStatus) }

    before do
      allow(Webhook::SlackSmsStatus).to receive(:new).
        with('sent', 'The Hatch SMS Status').
        and_return(request_object)
    end

    it 'returns request slack object' do
      expect(sms_status).to eql(request_object)
    end
  end

  describe '#authorized?' do
    subject { authorized? }

    let(:request_object) { double('FakeWebhook', path_info: path) }
    let(:path) { '/sms' }
    let(:token) { 'token' }

    before do
      allow(FakeSmsHelper::FakeWebhook).to receive(:new).and_return(request_object)
      allow(ENV).to receive(:[]).with('SMS_TOKEN').and_return(token)
    end

    context 'URL is /status' do
      let(:path) { '/status' }

      it { is_expected.to eql(true) }
    end

    context 'URL is NOT /status' do
      context 'SMS token is correct' do
        it { is_expected.to eql(true) }
      end

      context 'SMS token is NOT correct' do
        let(:token) { 'invalid' }

        it { is_expected.to eql(false) }
      end
    end
  end
end
