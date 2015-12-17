require './spec/spec_helper'

describe OrdersController do
  subject(:status) { last_response.status }

  describe 'GET /orders' do
    before do
      allow(Order).to receive(:todays_orders).and_return([])
    end

    it 'returns status of 200' do
      get '/'
      expect(status).to eql(200)
    end

    it 'calls todays_orders method on OrderPresenter' do
      expect(OrderPresenter).to receive(:todays_orders)
      get '/'
    end
  end

  def app;OrdersController;end
end
