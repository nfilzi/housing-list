source 'https://rubygems.org'

ruby '2.4.2'

gem 'rake'
gem 'hanami',       '~> 1.0'

# FIXME: Using develop branch to have access to belongs_to association.
# This hack should be removed as soon as hanami-model version is bumped.
# gem 'hanami-model', '~> 1.0'
gem 'hanami-model', '~> 1.0', github: 'hanami/model', branch: 'develop'

gem 'pg'

# assets
gem 'sass'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun'
  gem 'pry'
end

group :test, :development do
  gem 'dotenv', '~> 2.0'
end

group :test do
  gem 'minitest'
  gem 'capybara'
end

group :production do
  # gem 'puma'
end
