require "sinatra/base"
require "haml"
require "sass"
require "yaml"

begin
  require "coffee-script"
rescue Exception => error
  puts "No JavaScript environment was found. Please install therubyracer gem"
  puts "  gem install therubyracer"
  Process.exit!
end

module Sinatra
  module Piano
    def try_haml(template)
      file_name = "#{pwd}/#{template}.haml"
      bad_luck file_name unless File.exists? file_name
     
      if etags?
        hash = hash_for template, :haml
        hash += hash_for "data/#{template}", :yaml if File.exists? "#{pwd}/data/#{template}.yaml"
        etag hash
      end
      haml template.to_sym
    end
    
    def sass(template)
      file_name = "#{pwd}/#{template}.sass"
      bad_luck file_name unless File.exists? file_name

      etag hash_for(template, :sass) if etags?
      Sass.compile File.read(file_name), :syntax => :sass
    end
  
    def coffee(template)
      file_name = "#{pwd}/#{template}.coffee"
      bad_luck file_name unless File.exists? file_name
      
      etag hash_for(template, :coffee) if etags?
      CoffeeScript.compile(File.read(file_name))
    end
    
    def data_for(template)
      file_name = "#{pwd}/data/#{template}.yaml"
      YAML.load_file(file_name) if File.exists?(file_name)
    end
    
    def style(path)
      "<link rel='stylesheet' type='text/css' href='#{path}' />"
    end
    
    def script(path)
      "<script type='text/javascript' src='#{path}'></script>"
    end
    
    def pwd
      settings.views
    end
    
    def bad_luck(path)
      content_type :html
      if settings.environment == :production
        if File.exists? "#{pwd}/404.haml"
          @data = data_for "404"
          halt 404, haml(:"404")
        else
          halt 404, "<h1>404 - Not Found</h1><p>Piano has found nothing in this address</p>"
        end
      else
        halt 404, "<h1>You have still to put something here.</h1><p>This is <em>#{path}</em></p><blockquote>Good luck!</blockquote>"
      end
    end
    
    def hash_for(name, type)
      "#{name}.#{type} - " + File.mtime("#{pwd}/#{name}.#{type}").to_s
    end
    
    def extract(text, length = 80)
      words = text.gsub(/<.+?>/, "").split
      return text if words.length <= length
      words[0..(length-1)].join(" ") + "..."
    end
    
    def link(text, length = 5)
      words = text
                .gsub(/<.+?>/, "")
                .gsub(" ", "-")
                .downcase
                .gsub(/[^a-z0-9\-]/, "")
                .split("-")
      words[0..(length-1)].join("-")
    end
    
    def etags?
      settings.etags == :on
    end
  end
  
  helpers Piano
end



class Piano < Sinatra::Base
  helpers Sinatra::Piano
  
  set :root, File.expand_path(Dir.pwd)
  set :views, File.expand_path(Dir.pwd)
  set :etags, :on
  
  def self.play!
    self.run!
  end
end