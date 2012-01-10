source 'http://rubygems.org'

gem 'rails', '3.0'
gem 'sqlite3-ruby', :require => 'sqlite3'
gem 'will_paginate'
gem 'acts-as-taggable-on', '~>2.1.0'

if RUBY_VERSION >= "1.9.3"
  gem "rake", '~>0.9.3.beta.1'
end

if ENV['PRODUCTION']
  gem "mysql"
end

if ENV['TEST']
  gem "mysql"
  gem "pg"
end
