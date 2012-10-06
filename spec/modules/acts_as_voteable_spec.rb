require_relative '../spec_helper'

describe 'ActsAsVoteable' do
  let(:user1) { User.create! }
  let(:user2) { User.create! }
  let(:user3) { User.create! }
  let(:item)  { Item.create! }
  let(:item2) { Item.create! }

  before do
    user1.vote_up(item)
    user2.vote_down(item)
    user3.vote_up(item)
    user1.vote_down(item2)
  end

  describe '#up_votes' do
    it 'should return the number of positive votes for voteable' do
      item.up_votes.must_equal 2
    end
  end

  describe '#down_votes' do
    it 'should return the number of negative votes for voteable' do
      item.down_votes.must_equal 1
    end
  end

  describe '#up_percentage' do
    it 'should return the percentage of positive votes' do
      item.up_percentage.must_equal 67
    end
  end

  describe '#down_percentage' do
    it 'should return the percentage of negative votes' do
      item.down_percentage.must_equal 33
    end

    it 'should return 100% if the item has 1 negative vote' do
      item2.down_percentage.must_equal 100
    end

    it 'should return 0 if the item has 0 positive vote' do
      item2.up_percentage.must_equal 0
    end
  end

  describe '#voters' do
    it 'should return the list of voters' do
      item.voters.sort.must_equal [user2, user1, user3].sort
      item2.voters.must_equal [user1]
    end
  end
end
