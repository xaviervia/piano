require "sinatra/base"
require "haml"
require "sass"
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

module Piano
  class Base < Sinatra::Base      
    register Sinatra::Piano
    
    set :root, File.expand_path(Dir.pwd)
    set :views, File.expand_path(Dir.pwd)
    set :data, File.expand_path(Dir.pwd + "/data")
    set :etags, :on
    set :i18n_path, File.expand_path(Dir.pwd) + "/config/locale"
    
    def self.i18n!
      return unless Dir.exists? self.i18n_path
      dir = Dir.new self.i18n_path
      i18n_files = []
      dir.each do |file|
        if file.end_with?(".yml") or file.end_with?(".yaml")
          i18n_files << "#{dir.path}/#{file}"
        end
      end
      I18n.load_path = i18n_files
    end
    
    def self.play!
      self.run! 
    end
  end
end

require "piano/controllerloader"
