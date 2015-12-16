require './spec/spec_helper'

describe CustomReply do
  subject { CustomReply.format('reply this is a string') }

  describe '#format' do
    it { is_expected.to eql('this is a string') }
  end
end
