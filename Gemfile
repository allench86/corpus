source 'https://rubygems.org'

ruby "2.0.0", :engine => "jruby", :engine_version => "1.7.11"

gem 'rails', '3.2.13'

gem 'activerecord-jdbcsqlite3-adapter'

gem 'jruby-openssl'
gem 'json'
gem 'bcrypt-ruby', '3.0.1'
gem 'bootstrap-sass', '2.1'
gem 'faker', '1.0.1'
gem 'will_paginate', '3.0.3'
gem 'bootstrap-will_paginate', '0.0.6'

gem 'sunspot_rails'
gem 'sunspot_solr' # optional pre-packaged Solr distribution for use in development

group :development, :test do
  gem 'jasmine'
  gem 'rspec-rails'
  gem 'capybara', "< 2.0.0"
  gem 'factory_girl_rails', '4.1.0'
end

group :test do
  gem 'annotate', '2.5.0'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'