require './spec/spec_helper'

describe Command do
  let(:command) { Command.new(text) }

  describe '#cancel?' do
    subject { command.cancel? }

    context 'text contains cancel command' do
      let(:text) { 'cancel'}

      it { is_expected.to eql(true) }
    end

    context 'text does not contain cancel command' do
      let(:text) { 'Chicken burger'}

      it { is_expected.to eql(false) }
    end
  end

  describe '#reply?' do
    subject { command.reply? }

    context 'text contains reply command' do
      let(:text) { 'reply yes that is fine'}

      it { is_expected.to eql(true) }
    end

    context 'text does not contain reply command' do
      let(:text) { 'Chicken burger'}

      it { is_expected.to eql(false) }
    end
  end
end
