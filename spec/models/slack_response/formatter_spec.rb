require './spec/spec_helper'

describe SlackResponse::Formatter do
  let(:text) { 'main text' }
  let(:secondary) { 'secondary text' }

  describe '#display' do
    subject { SlackResponse::Formatter.display(text, secondary) }

    let(:output) {
      {
        response_type: 'in_channel',
        text: 'main text',
        attachments: [
          { text: 'secondary text' }
        ]
      }
    }

    it { is_expected.to eql(output) }
  end
end
