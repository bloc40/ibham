module Ibham
  module ActsAsVoteable
    extend ActiveSupport::Concern

    module ClassMethods
      def acts_as_voteable
        class_eval do
          include Voteable
        end
      end
    end

    module Voteable
      extend ActiveSupport::Concern
      DELTA = 0.00001

      included do
        has_many :votes, :as => :voteable, :dependent => :destroy
      end

      def up_votes
        votes.where(value: ALLOWED_VALUE).count
      end

      def down_votes
        votes.where(value: -ALLOWED_VALUE).count
      end

      def up_percentage
        (up_votes * 100 / (votes.count.to_f + DELTA)).round
      end

      def down_percentage
        100 - up_percentage
      end

      def voters
        votes.map(&:voter)
      end
    end
  end
end
