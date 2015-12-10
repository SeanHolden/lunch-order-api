require './spec/spec_helper'

describe Response::Order do
  subject(:response_order) {
    Response::Order.new('John Smith', 'Chicken Burger')
  }

  describe '#success' do
    let(:mock_today) { Date.parse("2016-01-01") }

    before do
      allow(DateTime).to receive(:now).and_return(mock_time)
      allow(Date).to receive(:today).and_return(mock_today)
      allow(Time).to receive(:now).and_return(mock_time)
    end

    context 'before time deadline' do
      let(:mock_time) { DateTime.parse("2016-01-01 10:00am") }
      let(:text) { 'Order placed for John Smith.' }
      let(:secondary) { "A text will be sent at 11:40am for:\nChicken Burger" }

      it 'returns order_placed message' do
        expect(Response::InChannel).to receive(:display).with(text, secondary)
        response_order.success
      end
    end

    context 'after time deadline' do
      let(:mock_time) { DateTime.parse("2016-01-01 11:45am") }
      let(:text) {
        'Sorry, John Smith. Order deadline was 11:40am. It is currently 11:45am'
      }
      let(:secondary) {
        'You can still text your own order with: +447123456789'
      }

      it 'returns too_late message' do
        expect(Response::InChannel).to receive(:display).with(text, secondary)
        response_order.success
      end
    end
  end

  describe '#error' do
    let(:text) { 'Oh no, something went wrong.' }
    let(:secondary) { 'Order for John Smith did not save.' }

    it 'returns error message' do
      expect(Response::InChannel).to receive(:display).with(text, secondary)
      response_order.error
    end
  end
end
