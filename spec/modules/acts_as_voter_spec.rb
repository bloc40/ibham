require_relative '../spec_helper'

describe 'ActsAsVoter' do
  let(:user) { User.create! }
  let(:item) { Item.create! }

  describe '#can_vote_for?' do
    it 'should return true if the voter can vote for an item' do
      user.can_vote_for?(item).must_equal true
    end

    it 'should return false if the voter can not vote for an item' do
      user.vote_down(item)
      user.can_vote_for?(item).must_equal false
    end
  end

  describe '#vote_up' do
    it 'should create a positive vote' do
      vote_count = Vote.count
      user.vote_up(item)
      Vote.count.must_equal vote_count + 1
      Vote.last.value.must_equal 1
    end
  end

  describe '#vote_down' do
    it 'should create a positive vote' do
      vote_count = Vote.count
      user.vote_down(item)
      Vote.count.must_equal vote_count + 1
      Vote.last.value.must_equal -1
    end
  end
end
