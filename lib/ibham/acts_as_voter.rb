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
        has_many :votes, as: :voter, dependent: :destroy
      end

      def can_vote_for?(voteable)
        votes.build(voteable: voteable, value: 1).valid?
      end

      def vote_up(voteable)
        votes.create(voteable: voteable, value: 1)
      end

      def vote_down(voteable)
        votes.create(voteable: voteable, value: -1)
      end
    end
  end
end
