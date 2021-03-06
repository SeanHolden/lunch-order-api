require './spec/spec_helper'

describe SlackResponse do
  subject { SlackResponse.new('johnsmith', text) }

  let(:text) { 'some text' }

  describe '#cancel' do
    let(:expected_hash) {
      {
        response_type: 'in_channel',
        text: 'All orders cancelled for johnsmith',
        attachments: [{ text: '' }],
      }
    }

    it 'returns expected hash' do
      expect(subject.cancel).to eql(expected_hash)
    end
  end

  describe '#special_cancel' do
    let(:text) { 'cancel someonesorder' }
    let(:expected_hash) {
      {
        response_type: 'in_channel',
        text: 'All orders cancelled for someonesorder',
        attachments: [{ text: '' }],
      }
    }

    it 'returns expected hash' do
      expect(subject.special_cancel).to eql(expected_hash)
    end
  end

  describe '#special_cancel_failed' do
    let(:text) { 'cancel someonesorder' }
    let(:expected_hash) {
      {
        response_type: 'in_channel',
        text: 'someonesorder is not a valid username',
        attachments: [{ text: 'No order was cancelled' }],
      }
    }

    it 'returns expected hash' do
      expect(subject.special_cancel_failed).to eql(expected_hash)
    end
  end

  describe '#reply' do
    let(:text) { 'reply some reply text' }
    let(:expected_hash) {
      {
        response_type: 'in_channel',
        text: 'Reply sent:',
        attachments: [{ text: 'some reply text' }],
      }
    }

    it 'returns expected hash' do
      expect(subject.reply).to eql(expected_hash)
    end
  end

  describe '#check' do
    let(:todays_orders) {
      "a: b\nc: d"
    }
    let(:expected_hash) {
      {
        response_type: 'in_channel',
        text: 'Orders so far:',
        attachments: [
          { text: "a: b\nc: d" }
        ],
      }
    }

    before do
      allow(OrderPresenter).to receive(:todays_orders_slack_format).
        and_return(todays_orders)
    end

    it 'returns expected hash' do
      expect(subject.check).to eql(expected_hash)
    end
  end

  describe '#menu' do
    let(:expected_hash) {
      {
        text: '',
        attachments: [
          {
            fallback: 'Menu',
            image_url: 'http://i.imgur.com/1sos6Yu.jpg',
          }
        ]
      }
    }
    it 'returns expected hash' do
      expect(subject.menu).to eql(expected_hash)
    end
  end
end
