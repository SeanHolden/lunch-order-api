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
      [{ name: 'a', order: 'b' }, { name: 'c', order: 'd'}]
    }
    let(:expected_hash) {
      {
        response_type: 'in_channel',
        text: 'Orders so far:',
        attachments: [
          { text: '[{"name":"a","order":"b"},{"name":"c","order":"d"}]' }
        ],
      }
    }

    before do
      allow(OrderPresenter).to receive(:todays_orders).and_return(todays_orders)
    end

    it 'returns expected hash' do
      expect(subject.check).to eql(expected_hash)
    end
  end
end
