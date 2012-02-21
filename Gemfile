source 'http://rubygems.org'

gem 'rails', '3.0'
gem 'will_paginate'
gem 'acts-as-taggable-on', '~>2.1.0'
gem 'sqlite3-ruby', :require => 'sqlite3'
gem 'maruku'

if RUBY_VERSION >= "1.9.3"
  gem "rake", '~>0.9.3.beta.1'
end

if ENV['PRODUCTION']
  ENV['DB'] = 'mysql' #default to mysql on production runs
end

db = ENV['DB'] || 'sqlite'

gem "mysql" if db == 'mysql'
gem "pg" if db == 'postgres'
