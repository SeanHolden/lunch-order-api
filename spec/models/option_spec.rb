require './spec/spec_helper'

describe Option do
  describe '#first' do
    subject { Option.new(text).first }

    let(:text) { 'cancel johnsmith' }

    it { is_expected.to eql('johnsmith') }

    context 'has no options' do
      let(:text) { 'cancel' }

      it { is_expected.to eql(nil) }
    end
  end
end
