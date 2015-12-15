require './spec/spec_helper'

describe CommandsController do
  describe 'POST /commands' do
    let(:params) { { text: text, user_name: user_name, token: token } }
    let(:text) { 'this is an order' }
    let(:user_name) { 'John Smith' }
    let(:order) { double(Order) }
    let(:token) { 'token' }
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

    context 'invalid token' do
      let(:token) { 'invalid' }

      it 'returns status of 401' do
        post '/', params
        expect(last_response.status).to eql(401)
      end
    end

    context 'has no command' do
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

    context 'has cancel command' do
      let(:text) { 'cancel' }
      let(:todays_orders) { [double('TodaysOrders')] }
      let(:expected_response) {
        {
          'response_type' => 'in_channel',
          'text' => 'All orders cancelled for John Smith',
          'attachments'=>[{ 'text' => '' }],
        }
      }

      before do
        allow(Order).to receive(:todays_orders).and_return(todays_orders)
        allow(todays_orders).to receive(:destroy_all)
      end

      it 'cancels all orders for that user' do
        expect(todays_orders).to receive(:destroy_all).
          with({name: 'John Smith'})
        post '/', params
      end

      it 'responds with correct response' do
        post '/', params
        expect(JSON.parse(last_response.body)).to eql(expected_response)
      end
    end
  end

  def app;CommandsController;end
end
