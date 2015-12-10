require './spec/spec_helper'

describe Sms::Client do
  describe '#body' do
    let(:body) { double(Sms::Body) }

    before { allow(Sms::Body).to receive(:new).and_return(body) }

    it 'returns SMS body' do
      expect(body).to receive(:to_s)
      Sms::Client.new.body
    end
  end
end
