require './spec/spec_helper'

describe OrdersHelper do
  include OrdersHelper
  include FakeOrdersHelper

  let(:user_name) { 'Test' }
  let(:text) { 'Testing 123' }

  describe '#order' do
    let(:order_object) { double(Order) }

    before do
      allow(Order).to receive(:new).
        with(name: user_name, text_order: text).
        and_return(order_object)
    end

    it 'returns new Order object' do
      expect(order).to eql(order_object)
    end
  end

  describe '#order_response' do
    let(:order_response_object) { double(SlackResponse::Order) }

    before do
      allow(SlackResponse::Order).to receive(:new).
        with(user_name, text).
        and_return(order_response_object)
    end

    it 'returns new Order object' do
      expect(order_response).to eql(order_response_object)
    end
  end

  describe '#todays_orders' do
    before do
      allow(OrderPresenter).to receive(:todays_orders).
        and_return(['array of orders'])
    end

    it 'returns new Order object' do
      expect(todays_orders).to eql(['array of orders'])
    end
  end
end
