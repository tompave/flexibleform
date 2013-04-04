source 'https://rubygems.org'

ruby '2.0.0'
gem 'rails', '3.2.13'


group :test do
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'faker'
end

group :development, :test do
	gem 'sqlite3'
	gem 'debugger'
  gem 'pry'	
	gem 'annotate'
  gem 'colorize'
	gem 'rspec-rails'

  gem 'meta_request', '~> 0.2.1' # to be used with 'rails_panel' chrome extension
  gem 'better_errors'
  gem 'binding_of_caller'
end


group :production do
	#gem 'mysql2'
  gem 'pg'
end

gem 'thin'
gem 'mail'

gem 'bootstrap-sass'
gem 'jquery-rails'

gem 'will_paginate'
gem 'bootstrap-will_paginate'

# https://github.com/achiu/rack-recaptcha
gem 'rack-recaptcha', :require => 'rack/recaptcha'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end


# To use ActiveModel has_secure_password
#gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'


# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'