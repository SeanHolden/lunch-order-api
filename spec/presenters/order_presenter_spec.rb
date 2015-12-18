require './spec/spec_helper'

describe OrderPresenter do
  let(:orders) {
    [
      double(Order, name: 'abc', text_order: 'Chicken Burger'),
      double(Order, name: 'def', text_order: 'Sausage Panini'),
      double(Order, name: 'ghi', text_order: 'Cheese and Ham Toastie'),
    ]
  }

  before { allow(Order).to receive(:todays_orders).and_return(orders) }

  describe '#todays_orders' do
    subject { OrderPresenter.todays_orders }

    let(:expected_output) {
      [
        { name: 'abc', order: 'Chicken Burger' },
        { name: 'def', order: 'Sausage Panini' },
        { name: 'ghi', order: 'Cheese and Ham Toastie' },
      ]
    }

    it { is_expected.to eql(expected_output) }
  end

  describe '#todays_orders_slack_format' do
    subject { OrderPresenter.todays_orders_slack_format }

    it 'returns output in newline format' do
      expect(subject).to eql(
        "abc: Chicken Burger\ndef: Sausage Panini\nghi: Cheese and Ham Toastie"
      )
    end
  end
end
