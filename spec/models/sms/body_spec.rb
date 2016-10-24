require './spec/spec_helper'

describe Sms::Body do
  describe '#to_s' do
    subject(:body) { Sms::Body.new.to_s }

    let(:order) { double(Order, text_order: 'Chicken Burger', name: 'Dave') }
    let(:order2) { double(Order, text_order: 'Cheese Burger', name: 'Paul') }
    let(:order3) { double(Order, text_order: 'Fish Burger', name: 'John') }

    before do
      allow(Order).to receive(:todays_orders).and_return(todays_orders)
      allow(todays_orders).to receive(:last).and_return(order)
    end

    context 'multiple orders' do
      let(:todays_orders) {
        [order, order2, order3]
      }
      let(:expected_body) { "Hello. Could I please place an order to collect around 12.\n1) Chicken Burger (Dave)\n2) Cheese Burger (Paul)\n3) Fish Burger (John)\nThank you!" }

      it 'returns text containing numbered list' do
        expect(body.to_s).to eql(expected_body)
      end
    end

    context 'one single order' do
      let(:todays_orders) {
        [order]
      }
      let(:expected_body) { "Hello. Could I please place an order to collect around 12.\n- Chicken Burger (Dave)\nThank you!" }

      it 'returns text containing single order preceded by a dash' do
        expect(body.to_s).to eql(expected_body)
      end
    end
  end
end
