source 'https://rubygems.org'

gem 'rails', '3.2.14'
gem 'haml-rails'

platforms :ruby do
  gem 'sqlite3'
  gem 'mysql2'
  gem 'pg'
  gem 'libv8'
  gem "therubyracer"
  gem 'thin'

  group :development do
    gem 'binding_of_caller'
    gem 'quiet_assets'
    gem 'better_errors'
    gem "rails-erd"
  end

end

platforms :jruby do
  gem "therubyrhino", group: :assets
  gem "trinidad", require: false
  gem 'trinidad_daemon_extension', require: false
  gem 'trinidad_worker_extension', require: false
  gem 'jruby-openssl'
  gem 'activerecord-jdbcsqlite3-adapter'
  gem 'activerecord-jdbcmysql-adapter'
  gem 'activerecord-jdbcpostgresql-adapter'
end


#gem 'rack-mini-profiler'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass'
  gem 'jquery-datatables-rails'
  gem 'jquery-ui-rails'
  gem 'jquery-fileupload-rails'
end

group :development, :test do
  gem 'brakeman'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :test do
  gem 'faker'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'simplecov'
  gem 'simplecov-rcov'
  gem 'ci_reporter'
end

gem 'jquery-rails'
gem 'coffee-rails', '~> 3.2.1'
gem 'paperclip'
gem 'morrisjs-rails'
gem 'raphael-rails'
gem 'smarter_csv'
gem 'will_paginate'
gem 'delayed_job_active_record'
gem 'ransack'
gem 'axlsx'
gem 'axlsx_rails'
gem 'devise'
gem 'cancan'
gem 'annotate'
gem 'workflow'
gem 'paper_trail'
gem 'turbolinks'
gem 'activerecord-postgres-hstore'

# adding sidekiq
gem 'sidekiq'
gem 'sinatra', require: false
gem 'slim'

gem "clockwork"
gem 'sanitize'
