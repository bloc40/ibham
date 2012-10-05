class IbhamCreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :voter, :polymorphic => true
      t.references :voteable, :polymorphic => true
      t.integer :value

      t.timestamps
    end

    add_index :votes, [:voter_id, :voter_type]
    add_index :votes, [:voteable_id, :voteable_type]
  end
end
