class Vote < ActiveRecord::Base

  ALLOWED_VALUE = 1

  attr_accessible :value, :voteable

  belongs_to :voteable, :polymorphic => true
  belongs_to :voter, :polymorphic => true

  validates_uniqueness_of :voteable_id, :scope => :voter_id
  validates :value, :inclusion => { :in => [ALLOWED_VALUE, -ALLOWED_VALUE], :message => "should be either #{ALLOWED_VALUE} or -#{ALLOWED_VALUE}" }
end
