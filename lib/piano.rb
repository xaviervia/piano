# -*- encoding : utf-8 -*-
require 'sinatra/base'
require 'sinatra/flash'
require 'piano/tilt_utf8_patch'

require 'haml'
require 'slim'
require 'sass'
require 'compass'
require 'yaml'
require 'i18n'

begin
  require 'coffee-script'
rescue Exception => error
  puts 'No JavaScript environment was found. Please install therubyracer gem'
  puts '  gem install therubyracer'
  Process.exit!
end

require 'sinatra/piano'

require 'piano/helpers/html'
require 'piano/base'
require 'piano/controller_loader'
require 'piano/version'
