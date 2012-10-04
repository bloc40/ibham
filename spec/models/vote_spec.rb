require 'spec_helper'

describe Vote do
  let(:user) { User.create!(email: 'foo@example.com') }
  let(:item) { Item.create!(name: 'item') }

  describe 'Validations' do
    it 'should be valid if the value is 1' do
      vote = Vote.new(value: 1)
      vote.should be_valid
    end

    it 'should be valid if the value is -1' do
      vote = Vote.new(value: -1)
      vote.should be_valid
    end

    it 'should fail if the value is other than 1 or -1' do
      vote = Vote.new(value: 2)
      vote.should_not be_valid
    end

    it 'should validate uniqueness of vote for voter and voteable' do
      user.vote_up(item)
      expect {
        user.vote_up(item)
      }.to change(Vote, :count).by(0)
    end
  end
end
