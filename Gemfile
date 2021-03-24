source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'rails', '~> 6.1.2', '>= 6.1.2.1'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'redis', '~> 4.0'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise'
gem 'autoprefixer-rails'
gem 'font-awesome-sass'
gem 'simple_form'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem "httparty", "~> 0.18.1"
gem "pagy", "~> 3.11"
gem "cloudinary", "~> 1.19"
gem "acts_as_favoritor", "~> 5.0"
gem "simple_calendar", "~> 2.4"
gem "sidekiq", "~> 6.1"
gem "hashie", "~> 4.1"
gem 'ransack'

group :development, :test do
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'dotenv-rails'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem "bullet", "~> 6.1"
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
