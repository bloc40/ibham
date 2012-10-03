class Vote < ActiveRecord::Base
  attr_accessible :value, :voteable

  belongs_to :voteable, polymorphic: true
  belongs_to :voter, polymorphic: true

  validates_uniqueness_of :voteable_id, scope: :voter_id
  validates :value, inclusion: { in: [1, -1] }
end
