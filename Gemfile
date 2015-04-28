source 'https://rubygems.org'

gem 'rails', '3.2.14'
gem 'haml-rails'

platforms :ruby do
  gem 'sqlite3'
  gem 'mysql2'
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
  gem 'activerecord-jdbcmysql-adapter','>= 1.3.2'
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
gem 'paper_trail'
gem 'turbolinks'

gem "whenever"
gem 'sanitize'
gem 'foreman', require: false

gem 'simple_form'
gem 'dotenv-rails'
