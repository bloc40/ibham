module Ibham
  module ActsAsVoter
    extend ActiveSupport::Concern

    module ClassMethods

      # To turn an abject to a voter, call <tt>acts_as_voter</tt> in the Active Record model class.
      #
      #   class User < ActiveRecord::Base
      #     acts_as_voter
      #   end
      def acts_as_voter
        class_eval do
          include Voter
        end
      end
    end

    module Voter
      extend ActiveSupport::Concern

      included do
        has_many :votes, :as => :voter, :dependent => :destroy
      end

      # To check if the voter (the user for example) can vote for this item,
      # call <tt>can_vote_for?</tt> on the voter with the object to vote for.
      #
      #   user.can_vote_for?(item)
      #
      # This will return either true for false
      def can_vote_for?(voteable)
        votes.build(:voteable => voteable, :value => ALLOWED_VALUE).valid?
      end

      # To cast a positive vote, the voter (e.g. the use) calls <tt>vote_up</tt>
      # with the object to vote for.
      #
      #   user.vote_up(item)
      #
      # This will add a new record with a positive vote for this item by this user in the votes table.
      def vote_up(voteable)
        votes.create(:voteable => voteable, :value => ALLOWED_VALUE)
      end

      # To cast a negative vote, the voter (e.g. the use) can call <tt>vote_up</tt>
      # with the object to vote for.
      #
      #   user.vote_up(item)
      #
      # This will add a new record with a negative vote for this item by this user in the votes table.
      def vote_down(voteable)
        votes.create(:voteable => voteable, :value => -ALLOWED_VALUE)
      end

      # To allow the user to dynamically cast a vote, call <tt>cast_vote</tt> with the item
      # to vote for and the value (1 or -1)
      #
      #   user.cast_vote(item, 1)
      #
      # This will add a new record with a positive vote.
      def cast_vote(voteable, value)
        votes.create(:voteable => voteable, :value => value)
      end
    end
  end
end
