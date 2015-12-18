require './spec/spec_helper'

describe CommandsController do
  describe 'POST /commands' do
    let(:params) {
      {
        text: text,
        user_name: user_name,
        token: token,
        user_id: '123',
        channel_id: channel_id
      }
    }
    let(:text) { 'this is an order' }
    let(:user_name) { 'John Smith' }
    let(:order) { double(Order) }
    let(:token) { 'token' }
    let(:channel_id) { '456' }
    let(:order_response) { double(SlackResponse::Order) }
    let(:order_saved) { true }

    before do
      allow(ENV).to receive(:[]).with('SLACK_TOKEN').and_return('token')
      allow(ENV).to receive(:[]).with('SLACK_CHANNEL_IDS').and_return('456,789')
      allow(Order).to receive(:new).
        with(name: user_name, text_order: text).and_return(order)
      allow(SlackResponse::Order).to receive(:new).
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

    context 'invalid channel_id' do
      let(:channel_id) { '111' }
      let(:expected_hash) {
        {
          response_type: 'in_channel',
          text: 'Wrong channel, silly!',
          attachments: [
            { text: 'This command will only work in #the-hatch' }
          ]
        }
      }

      it 'returns status of 401' do
        post '/', params
        expect(last_response.status).to eql(401)
      end

      it 'returns appropriate response' do
        post '/', params
        expect(last_response.body).to eql(expected_hash.to_json)
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

    context 'has special cancel command' do
      let(:mock_todays_orders) { double('TodaysOrders') }

      before do
        allow(Overseer).to receive(:pluck).with(:user_id).and_return([user_id])
        allow(Order).to receive(:todays_orders).and_return(mock_todays_orders)
        allow(mock_todays_orders).to receive(:destroy_all).
          with(name: 'someonesorder')
        allow(mock_todays_orders).to receive(:destroy_all).
          with(name: 'John Smith')
        allow(mock_todays_orders).to receive(:pluck).with(:name).
          and_return(['someonesorder'])
      end

      context 'is overseer' do
        let(:user_id) { '123' }
        let(:expected_hash) {
          {
            'response_type' => 'in_channel',
            'text' => 'All orders cancelled for someonesorder',
            'attachments' => [{ 'text' => '' }],
          }
        }

        context 'gives correct name of user' do
          let(:text) { 'cancel someonesorder' }

          it 'returns status of 200' do
            post '/', params
            expect(last_response.status).to eql(200)
          end

          it 'response is expected json hash' do
            post '/', params
            expect(JSON.parse(last_response.body)).to eql(expected_hash)
          end
        end

        context 'gives incorrect name of user' do
          let(:text) { 'cancel someonesorder2' }
          let(:expected_hash) {
            {
              'response_type' => 'in_channel',
              'text' => 'someonesorder2 is not a valid username',
              'attachments' => [{ 'text' => 'No order was cancelled' }],
            }
          }

          it 'returns status of 200' do
            post '/', params
            expect(last_response.status).to eql(200)
          end

          it 'response is expected json hash' do
            post '/', params
            expect(JSON.parse(last_response.body)).to eql(expected_hash)
          end
        end
      end

      context 'is NOT overseer' do
        let(:user_id) { '456' }

        context 'gives correct name of user' do
          let(:text) { 'cancel someonesorder' }
          let(:expected_response) {
            {
              'response_type' => 'in_channel',
              'text' => 'All orders cancelled for John Smith',
              'attachments'=>[{ 'text' => '' }],
            }
          }

          it 'response is NOT special, just normal cancel json hash' do
            post '/', params
            expect(JSON.parse(last_response.body)).to eql(expected_response)
          end
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

    context 'has menu command' do
      let(:text) { 'menu' }
      let(:expected_response) {
        {
          'text' => '',
          'attachments' => [
            {
              'fallback' => 'Menu',
              'image_url' => 'http://i.imgur.com/1sos6Yu.jpg',
            }
          ]
        }
      }

      it 'responds with menu iamge' do
        post '/', params
        expect(JSON.parse(last_response.body)).to eql(expected_response)
      end
    end

    context 'has reply command' do
      let(:text) { 'reply this is a string of text' }
      let(:sms_client) { double(Sms::Client) }

      before do
        allow(Overseer).to receive(:pluck).with(:user_id).and_return([user_id])
        allow(Sms::Client).to receive(:new).with('this is a string of text').
          and_return(sms_client)
        allow(sms_client).to receive(:send_sms)
      end

      context 'is overseer' do
        let(:user_id) { '123' }

        it 'sends a custom reply sms' do
          expect(sms_client).to receive(:send_sms)
          post '/', params
        end

        it 'returns appropriate JSON response' do
          post '/', params
          expect(JSON.parse(last_response.body)).to eql(
            {
              'response_type' => 'in_channel',
              'text' => 'Reply sent:',
              'attachments' => [{ 'text' => 'this is a string of text' }]
            }
          )
        end
      end

      context 'is NOT overseer' do
        let(:user_id) { '321' }

        it 'does not send a custom reply sms' do
          expect(sms_client).to_not receive(:send_sms)
          post '/', params
        end
      end
    end

    context 'has check command' do
      let(:text) { 'check' }
      let(:order1) { double(Order, name: 'john', text_order: 'chicken') }
      let(:order2) { double(Order, name: 'bob', text_order: 'beef') }

      before do
        allow(Overseer).to receive(:pluck).with(:user_id).and_return([user_id])
        allow(Order).to receive(:todays_orders).and_return([order1, order2])
      end

      context 'is overseer' do
        let(:user_id) { '123' }

        it 'returns appropriate JSON response' do
          post '/', params
          expect(JSON.parse(last_response.body)).to eql(
            {
              'response_type' => 'in_channel',
              'text' => 'Orders so far:',
              'attachments' => [
                {
                  'text' => "john: chicken\nbob: beef"
                }
              ]
            }
          )
        end
      end

      context 'is NOT overseer' do
        let(:user_id) { '321' }

        it 'does not perform a check' do
          expect(order_response).to receive(:success)
          post '/', params
        end
      end
    end
  end

  def app;CommandsController;end
end
