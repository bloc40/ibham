require 'active_record'
require 'sqlite3'
require 'ibham'
require 'minitest/autorun'

ActiveRecord::Migration.verbose = false

class MiniTest::Spec
  before do
    User.destroy_all
    Item.destroy_all
    Vote.destroy_all
  end

  config = {
    :adapter => 'sqlite3',
    :database => ':memory:'
  }

  ActiveRecord::Base.establish_connection(config)
  ActiveRecord::Base.connection.create_database config[:database] rescue nil
  ActiveRecord::Base.connection.drop_database config[:database] rescue nil
end

ActiveRecord::Schema.define do
  create_table :votes do |t|
    t.references :voter, :polymorphic => true
    t.references :voteable, :polymorphic => true
    t.integer :value

    t.timestamps
  end

  add_index :votes, [:voter_id, :voter_type]
  add_index :votes, [:voteable_id, :voteable_type]

  create_table :users do |t|
    t.string :email
    t.timestamps
  end

  create_table :items do |t|
    t.string :name
    t.timestamps
  end
end

class User < ActiveRecord::Base
  has_many :items
  acts_as_voter
end

class Item < ActiveRecord::Base
  belongs_to :user
  acts_as_voteable
end
