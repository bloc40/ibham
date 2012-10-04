require_relative '../spec_helper'

describe Vote do
  let(:user) { User.create!(email: 'foo@example.com') }
  let(:item) { Item.create!(name: 'item') }

  describe 'Validations' do
    it 'should be valid if the value is 1' do
      vote = Vote.new(value: 1)
      vote.valid?.must_equal true
    end

    it 'should be valid if the value is -1' do
      vote = Vote.new(value: -1)
      vote.valid?.must_equal true
    end

    it 'should fail if the value is other than 1 or -1' do
      vote = Vote.new(value: 2)
      vote.valid?.must_equal false
    end

    it 'should validate uniqueness of vote for voter and voteable' do
      user.vote_up(item)
      Vote.count.must_equal 1
      user.vote_up(item)
      Vote.count.must_equal 1
    end
  end
end
