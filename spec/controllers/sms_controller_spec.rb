require './spec/spec_helper'

describe SmsController do
  let(:parsed_body) { JSON.parse(last_response.body) }
  let(:orders) { false }
  let(:no_orders_message) { { 'message' => 'No orders placed today' } }
  let(:sms) { double(Sms, body: sms_body) }
  let(:sms_body) { 'This is the SMS body' }

  before do
    allow(Order).to receive(:any?).and_return(orders)
    allow(Sms).to receive(:new).and_return(sms)
  end

  describe 'GET /sms' do
    it 'returns status of 200' do
      get '/'
      expect(last_response.status).to eql(200)
    end

    context 'no orders have been placed' do
      it 'returns appropriate json response' do
        get '/'
        expect(parsed_body).to eql(no_orders_message)
      end
    end

    context 'orders have been placed today' do
      let(:orders) { true }

      it 'returns body of the proposed SMS' do
        get '/'
        expect(last_response.body).to eql(sms_body)
      end
    end
  end

  describe 'POST /sms' do
    let(:headers) { { 'HTTP_SMS_TOKEN' => token} }
    let(:token) { 'token' }

    before do
      allow(ENV).to receive(:[]).with('SMS_TOKEN').and_return('token')
    end

    context 'authentication fails' do
      let(:token) { 'invalid_token' }

      it 'returns status of 401' do
        post '/', nil, headers
        expect(last_response.status).to eql(401)
      end
    end

    context 'authentication passes' do
      context 'no orders placed today' do
        it 'returns appropriate json response' do
          post '/', nil, headers
          expect(parsed_body).to eql(no_orders_message)
        end
      end

      context 'some orders placed today' do
        let(:orders) { true }

        before do
          allow(sms).to receive(:send).and_return('response for sent SMS')
        end

        it 'sms gets sent' do
          post '/', nil, headers
          expect(parsed_body).to eql(
            {
              'message' => 'SMS sent',
              'body' => sms_body,
              'response' => 'response for sent SMS'
            }
          )
        end
      end
    end
  end

  def app;SmsController;end
end
