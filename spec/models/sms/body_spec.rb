require './spec/spec_helper'

describe Sms::Body do
  describe '#to_s' do
    subject(:body) { Sms::Body.new.to_s }

    let(:order) { double(Order, text_order: 'Chicken Burger') }
    let(:todays_orders) { double('TodaysOrders') }

    before do
      allow(Order).to receive(:todays_orders).and_return(todays_orders)
      allow(todays_orders).to receive(:last).and_return(order)
      allow(todays_orders).to receive(:pluck).
        with(:text_order).
        and_return(text_orders)
    end

    context 'multiple orders' do
      let(:text_orders) {
        [order.text_order, order.text_order, order.text_order]
      }
      let(:expected_body) { "Hello. Could I please place another order to collect around 12.\n1) Chicken Burger\n2) Chicken Burger\n3) Chicken Burger\nThank you!" }

      it 'returns text containing numbered list' do
        expect(body.to_s).to eql(expected_body)
      end
    end

    context 'one single order' do
      let(:text_orders) {
        [order.text_order]
      }
      let(:expected_body) { "Hello. Could I please place another order to collect around 12.\n- Chicken Burger\nThank you!" }

      it 'returns text containing single order preceded by a dash' do
        expect(body.to_s).to eql(expected_body)
      end
    end
  end
end
