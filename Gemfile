source "http://rubygems.org"

gemspec

if RUBY_PLATFORM =~ /linux/
  gem "therubyracer"
end

group :test do 
  gem 'rack-test', :git => "https://github.com/brynary/rack-test.git"
  gem 'pry'
  gem 'fast'
end
