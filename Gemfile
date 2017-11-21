source 'https://rubygems.org'

ruby '2.4.2'

gem 'rake'
gem 'hanami',       '~> 1.0'

# FIXME: Using develop branch to have access to belongs_to association.
# This hack should be removed as soon as hanami-model version is bumped.
# gem 'hanami-model', '~> 1.0'
gem 'hanami-model', '~> 1.0', github: 'hanami/model', branch: 'develop'

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

# debugging scrapers
# gem 'selenium-webdriver'
# gem 'chromedriver-helper'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun'
  gem 'pry-byebug'
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
