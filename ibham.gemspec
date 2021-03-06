# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ibham/version'

Gem::Specification.new do |gem|
  gem.name          = 'ibham'
  gem.version       = Ibham::VERSION
  gem.authors       = ['Jamal El Milahi']
  gem.email         = ['jamal@elmilahi.com']
  gem.description   = %q{Voting System for Rails applications}
  gem.summary       = %q{Ibham is a gem that allows Rails apps to compute and display voting scores for active records models.}
  gem.homepage      = 'https://github.com/bloc40/ibham'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'activerecord'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'sqlite3'
end
