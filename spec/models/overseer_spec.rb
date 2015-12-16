require './spec/spec_helper'

describe Overseer do
  it { is_expected.to respond_to(:user_name) }
  it { is_expected.to respond_to(:user_id) }
  it { is_expected.to respond_to(:created_at) }
  it { is_expected.to respond_to(:updated_at) }

  describe 'validations' do
    subject { Overseer.new(user_name: user_name, user_id: user_id) }

    let(:user_name) { 'johnsmith' }
    let(:user_id) { '123XYZ' }

    context 'with user_name and user_id' do
      it { is_expected.to be_valid }
    end

    context 'user_name is nil' do
      let(:user_name) { nil }

      it { is_expected.to_not be_valid }
    end

    context 'user_id is nil' do
      let(:user_id) { nil }

      it { is_expected.to_not be_valid }
    end
  end
end
