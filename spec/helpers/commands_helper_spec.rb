require './spec/spec_helper'

describe CommandsHelper do
  include CommandsHelper
  include FakeCommandsHelper

  let(:user_name) { 'johnsmith' }
  let(:text) { 'this is some text' }
  let(:user_id) { '123' }

  describe '#command' do
    let(:command_object) { double(Command) }

    before do
      allow(Command).to receive(:new).with(text).and_return(command_object)
    end

    it 'creates new command object' do
      expect(command).to eql(command_object)
    end
  end

  describe '#cancel_user_orders' do
    let(:todays_orders) { double('Orders') }

    before do
      allow(Order).to receive(:todays_orders).and_return(todays_orders)
    end

    it 'cancels all todays orders for this user' do
      expect(todays_orders).to receive(:destroy_all).with(name: 'johnsmith')
      cancel_user_orders
    end
  end

  describe '#slack_response' do
    let(:mock_slack_response) { double(SlackResponse) }

    before do
      allow(SlackResponse).to receive(:new).with(user_name, text).
        and_return(mock_slack_response)
    end

    it 'creates new SlackResponse object' do
      expect(slack_response).to eql(mock_slack_response)
    end
  end

  describe '#overseer?' do
    before do
      allow(Overseer).to receive(:pluck).with(:user_id).and_return(user_ids)
    end

    context 'user id is present in overseer table' do
      let(:user_ids) { ['123'] }

      it 'returns true' do
        expect(overseer?).to eql(true)
      end
    end

    context 'user id is NOT present in overseer table' do
      let(:user_ids) { [] }

      it 'returns false' do
        expect(overseer?).to eql(false)
      end
    end
  end

  describe '#reply' do
    let(:reply_object) { double(Sms::Client) }
    let(:text) { 'reply this is some text' }

    before do
      allow(Sms::Client).to receive(:new).
        with('this is some text').and_return(reply_object)
    end

    it 'creates new Sms::Client object' do
      expect(reply).to eql(reply_object)
    end
  end

  describe '#place_order' do
    let(:order_response_object) { double(SlackResponse::Order) }
    let(:order_object) { double(Order) }

    before do
      allow(Order).to receive(:new).and_return(order_object)
      allow(order_object).to receive(:save).and_return(order_save)
      allow(SlackResponse::Order).to receive(:new).
        and_return(order_response_object)
    end

    context 'order saves' do
      let(:order_save) { true }

      it 'calls success method on order response' do
        expect(order_response_object).to receive(:success)
        place_order
      end
    end

    context 'order does NOT save' do
      let(:order_save) { false }

      it 'calls error method on order response' do
        expect(order_response_object).to receive(:error)
        place_order
      end
    end
  end

  describe '#order' do
    let(:order_object) { double(Order) }

    before do
      allow(Order).to receive(:new).
        with(name: 'johnsmith', text_order: 'this is some text').
        and_return(order_object)
    end

    it 'creates new Order object' do
      expect(order).to eql(order_object)
    end
  end

  describe '#order_response' do
    let(:order_response_object) { double(SlackResponse::Order) }

    before do
      allow(SlackResponse::Order).to receive(:new).
        with('johnsmith', 'this is some text').
        and_return(order_response_object)
    end

    it 'creates new SlackResponse::Order object' do
      expect(order_response).to eql(order_response_object)
    end
  end

  describe '#formatted_reply' do
    let(:text) { 'reply hello world' }

    it 'returns reply text without the reply command' do
      expect(formatted_reply).to eql('hello world')
    end
  end
end
