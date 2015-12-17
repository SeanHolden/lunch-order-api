require './spec/spec_helper'

describe OrdersHelper do
  include OrdersHelper

  let(:user_name) { 'Test' }
  let(:text) { 'Testing 123' }

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
