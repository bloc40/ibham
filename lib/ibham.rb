require 'ibham/version'
require 'ibham/acts_as_voter'
require 'ibham/acts_as_voteable'
require 'models/vote'

module Ibham
  # Your code goes here...
end

ActiveRecord::Base.class_eval do
  include Ibham::ActsAsVoter
  include Ibham::ActsAsVoteable
end
