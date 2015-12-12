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

  describe 'POST /orders' do
    let(:order) { double(Order) }
    let(:user_name) { 'John Smith' }
    let(:text) { 'Chicken Burger' }
    let(:token) { 'token' }
    let(:params) { { token: token, user_name: user_name, text: text } }
    let(:order_response) { double(Response::Order) }
    let(:order_saved) { true }

    before do
      allow(ENV).to receive(:[]).with('SLACK_TOKEN').and_return('token')
      allow(Order).to receive(:new).
        with(name: user_name, text_order: text).and_return(order)
      allow(Response::Order).to receive(:new).
        with(user_name, text).and_return(order_response)
      allow(order).to receive(:save).and_return(order_saved)
      allow(order_response).to receive(:success).and_return(true)
    end

    context 'authentication fails' do
      let(:token) { 'invalid_token' }

      it 'returns status of 401' do
        post '/', params
        expect(status).to eql(401)
      end
    end

    context 'authentication passes' do
      context 'order saves successfully' do
        it 'returns status of 200' do
          post '/', params
          expect(last_response.status).to eql(200)
        end

        it 'calls success method' do
          expect(order_response).to receive(:success)
          post '/', params
        end
      end

      context 'order fails to save' do
        let(:order_saved) { false }

        before do
          allow(order_response).to receive(:error).and_return(true)
        end

        it 'returns status of 200' do
          post '/', params
          expect(last_response.status).to eql(200)
        end

        it 'calls error method' do
          expect(order_response).to receive(:error)
          post '/', params
        end
      end
    end
  end

  def app;OrdersController;end
end
