require 'spec_helper'

describe 'ActsAsVoter' do
  let(:user) { User.create!(email: 'foo@example.com') }
  let(:item) { Item.create!(name: 'item') }

  describe '#can_vote_for?' do
    it 'should return true if the voter can vote for an item' do
      user.can_vote_for?(item).should be_true
    end

    it 'should return false if the voter can not vote for an item' do
      user.vote_down(item)
      user.can_vote_for?(item).should be_false
    end
  end

  describe '#vote_up' do
    it 'should create a positive vote' do
      expect { user.vote_up(item) }.to change { Vote.count }.by(1)
      Vote.last.value.should == 1
    end
  end

  describe '#vote_down' do
    it 'should create a positive vote' do
      expect { user.vote_down(item) }.to change { Vote.count }.by(1)
      Vote.last.value.should == -1
    end
  end
end
