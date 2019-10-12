source 'https://rubygems.org'

ruby '2.6.5'

gem 'rake'
gem 'hanami',       '~> 1.1.1'
gem 'hanami-model', '~> 1.1'

gem 'bcrypt', '~> 3.1.11' # authentication
gem 'pg'

gem 'sidekiq'

# scraping
gem 'capybara'
gem 'poltergeist'
gem 'phantomjs', require: 'phantomjs/poltergeist'
gem 'launchy'

# file upload
gem 'uploadcare-ruby'

# assets
gem 'sass'

# monitoring
gem 'bugsnag'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun'
  gem 'pry-byebug'

  # debugging scrapers
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end

group :test, :development do
  gem 'dotenv', '~> 2.0'
end

group :test do
  gem 'minitest'
end

group :production do
  # gem 'puma'
end
