require "sinatra/base"
require "sinatra/flash"

require "haml"
require "sass"
require "compass"
require "yaml"
require "i18n"

begin
  require "coffee-script"
rescue Exception => error
  puts "No JavaScript environment was found. Please install therubyracer gem"
  puts "  gem install therubyracer"
  Process.exit!
end

require "sinatra/piano"

require "piano/base"
require "piano/controllerloader"
require "piano/version"
