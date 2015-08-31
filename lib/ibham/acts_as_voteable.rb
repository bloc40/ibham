module Ibham
  module ActsAsVoteable
    extend ActiveSupport::Concern

    module ClassMethods

      # To turn an abject to a voteable, call <tt>acts_as_voteable</tt> in the
      # Active Record model class.
      #
      #   class Item < ActiveRecord::Base
      #     acts_as_voteable
      #   end
      def acts_as_voteable
        class_eval do
          include Voteable
        end
      end
    end

    module Voteable
      extend ActiveSupport::Concern

      included do
        has_many :votes, as: :voteable, dependent: :destroy
      end

      # To ruturn the count of positive votes, call <tt>up_votes</tt> on the
      # voteable object.
      #
      #   item.up_votes
      def up_votes
        votes.where(value: ALLOWED_VALUE).count
      end

      # To ruturn the count of negative votes, call <tt>down_votes</tt> on the
      # voteable object.
      #
      #   item.down_votes
      def down_votes
        votes.where(value: -ALLOWED_VALUE).count
      end

      # To ruturn the percentage of positive votes, call <tt>up_percentage</tt>
      # on the voteable object.  This is ideal to use with sparkbars.
      #
      #   item.up_percentage
      def up_percentage
        (up_votes * 100 / (votes.count.to_f + DELTA)).round
      end

      # To ruturn the percentage of positive votes, call
      # <tt>down_percentage</tt> on the voteable object. This is ideal to use
      # with sparkbars.
      #
      #   item.down_percentage
      def down_percentage
        (down_votes * 100 / (votes.count.to_f + DELTA)).round
      end

      # To get the list of voters, call <tt>voters</tt> on the voteable object.
      #
      #   item.voters
      def voters
        votes.map(&:voter)
      end

      # To get the list of voters who casted positive votes, call
      # <tt>up_voters</tt> on the voteable object.
      #
      #   item.up_voters
      def up_voters
        votes.where(value: ALLOWED_VALUE).map(&:voter)
      end

      # To get the list of voters who casted negative votes, call
      # <tt>down_voters</tt> on the voteable object.
      #
      #   item.down_voters
      def down_voters
        votes.where(value: -ALLOWED_VALUE).map(&:voter)
      end

      # To get the result of the votes, call <tt>vote_sum</tt> on the
      # voteable object.
      #
      # item.vote_sum
      def vote_sum
        votes.sum(:value)
      end
    end
  end
end
