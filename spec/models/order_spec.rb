require './spec/spec_helper'

describe Order do
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:text_order) }
  it { is_expected.to respond_to(:created_at) }
  it { is_expected.to respond_to(:updated_at) }

  describe 'validations' do
    subject { Order.new(name: name, text_order: text_order) }

    let(:text_order) { 'Chicken Burger' }
    let(:name) { 'John Smith' }

    context 'with text_order' do
      it { is_expected.to be_valid }
    end

    context 'text_order is nil' do
      let(:text_order) { nil }

      it { is_expected.to_not be_valid }
    end

    context 'text_order is empty string' do
      let(:text_order) { '' }

      it { is_expected.to_not be_valid }
    end
  end

  describe 'before_create' do
    describe '#remove_duplicate' do
      before do
        Order.delete_all
        Order.create(text_order: 'testing', name: 'sean')
      end

      it 'removes duplicate order if one was made before this one by same person' do
        expect{ Order.create(text_order: 'testing', name: 'sean') }.not_to change{ Order.count }.from(1)
      end
    end
  end

  describe 'scopes' do
    describe '#todays_orders' do
      it 'calls the correct query' do
        expect(Order).to receive(:where).with('created_at >= CURDATE()')
        Order.todays_orders
      end
    end
  end

  describe '#any?' do
    subject { Order.any? }

    before do
      allow(Order).to receive(:todays_orders).and_return(orders)
    end

    context 'Some orders exist today' do
      let(:orders) { [double(Order)] }

      it { is_expected.to eql(true) }
    end

    context 'No orders exist today' do
      let(:orders) { [] }

      it { is_expected.to eql(false) }
    end
  end

  describe '#multiple?' do
    subject { Order.multiple? }

    before do
      allow(Order).to receive(:todays_orders).and_return(orders)
    end

    context 'Single order exists today' do
      let(:orders) { [double(Order)] }

      it { is_expected.to eql(false) }
    end

    context 'Multiple orders exist today' do
      let(:orders) { [double(Order), double(Order)] }

      it { is_expected.to eql(true) }
    end
  end
end
