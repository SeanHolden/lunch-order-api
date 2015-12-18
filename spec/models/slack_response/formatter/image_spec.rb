require './spec/spec_helper'

describe SlackResponse::Formatter::Image do
  describe '#display' do
    subject { SlackResponse::Formatter::Image.display(url) }

    let(:url) { 'http://test.com/img.png' }

    let(:output) {
      {
        response_type: 'in_channel',
        text: 'menu',
        attachments: [
          {
            fallback: 'Menu',
            image_url: url,
          }
        ]
      }
    }

    it { is_expected.to eql(output) }
  end
end
