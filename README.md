# Ibham [![Build Status](https://secure.travis-ci.org/bloc40/ibham.png)](http://travis-ci.org/bloc40/ibham) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/bloc40/ibham)

Ibham is a gem that allows Rails apps to compute and display voting scores for active records models.

## Installation

Add this line to your application's Gemfile:

    gem 'ibham'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ibham

Generate the migration

    $ rails g ibham:install
    $ rake db:migrate

# Usage

Let's say you have a user model (the voter). You need to add the mixin
*acts_as_voter* to that model:

    class User < ActiveRecord::Base
      acts_as_voter
    end

And let's say you have an item model that the user can cast vote for
(the voteable). you need to add the mixin *acts_as_voteable* to the item
model:

    class Item < ActiveRecord::Base
      acts_as_voteable
    end

### Casting votes

The user can cast votes in the following ways:

    # Let's first create a user and an item:
    user = User.create
    item = Item.create

    user.vote_up(item)        # Adds a positive vote
    user.vote_down(item)      # Adds a negative vote

or

    # The only allowed values are 1 and -1
    user.cast_vote(item, 1)   # Adds a positive vote
    user.cast_vote(item, -1)  # Adds a negative vote

Since a user can cast only one vote per item, to check if the user can
cast vote for an item:

    user.can_vote_for?(item)

### Retrieving votes

To retrieve the votes:

    item.up_votes             # Return the total number of positive votes
    item.down_votes           # Return the total number of negative votes

    item.up_percentage        # Return the percentage of positive votes
    item.down_percentage      # Return the percentage of negative votes

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
