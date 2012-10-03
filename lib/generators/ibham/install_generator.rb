require 'rails/generators/migration'
require 'rails/generators/active_record'

module Ibham
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    source_root File.expand_path('../templates', __FILE__)

    def self.next_migration_number(path)
      ActiveRecord::Generators::Base.next_migration_number(path)
    end

    desc 'Create migration file required by ibham gem.'
    def create_migration_file
      unless self.class.migration_exists?(File.dirname(File.expand_path('db/migrate/ibham_create_votes')), 'ibham_create_votes')
        migration_template 'migration.rb', 'db/migrate/ibham_create_votes.rb'
      end
    end
  end
end
