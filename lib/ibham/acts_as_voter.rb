module Ibham
  module ActsAsVoter
    extend ActiveSupport::Concern

    module ClassMethods
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

      def can_vote_for?(voteable)
        votes.build(:voteable => voteable, :value => ALLOWED_VALUE).valid?
      end

      def vote_up(voteable)
        votes.create(:voteable => voteable, :value => ALLOWED_VALUE)
      end

      def vote_down(voteable)
        votes.create(:voteable => voteable, :value => -ALLOWED_VALUE)
      end

      def cast_vote(voteable, value)
        votes.create(:voteable => voteable, :value => value)
      end
    end
  end
end
