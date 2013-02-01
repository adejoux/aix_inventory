source 'https://rubygems.org'

gem 'rails', '3.2.11'
gem 'haml-rails'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

platforms :ruby do
  gem 'sqlite3'
  gem 'mysql2'
  gem 'libv8'
  gem "therubyracer"
  
  group :development do
    gem 'binding_of_caller'
  end

end

platforms :jruby do
  gem "therubyrhino", group: :assets
  gem "trinidad", require: false
  gem 'jruby-openssl'
  gem 'activerecord-jdbcsqlite3-adapter'
  gem 'activerecord-jdbcmysql-adapter'
end

gem 'smarter_csv'
gem 'will_paginate'
gem 'ransack'
gem 'axlsx'
gem 'axlsx_rails'
gem 'devise'
gem 'cancan'
gem 'annotate'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
#  gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
  gem 'twitter-bootstrap-rails'
  gem 'jquery-datatables-rails'
  gem 'jquery-ui-rails'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :development do
  gem 'better_errors'
end

group :test do
  gem 'faker'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'launchy'
end

gem 'jquery-rails'
gem 'morrisjs-rails'
gem 'raphael-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
