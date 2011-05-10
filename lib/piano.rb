require "sinatra/base"
require "haml"
require "sass"
require "coffee-script"
require "yaml"

class Piano < Sinatra::Base
  set :root, File.expand_path(Dir.pwd)
  set :views, File.expand_path(Dir.pwd)
  
  get "/" do
    @data = data_for "index"
    try_haml "index"
  end
  
  get %r{/(.+?).css} do |something|
    content_type :css
    sass something
  end
  
  get %r{/(.+?).js} do |something|
    content_type :js
    coffee something
  end
  
  get %r{/(.+)$} do |something|
    @data = data_for something
    try_haml something
  end
  
  helpers do
    def try_haml(template)
      file_name = "#{pwd}/#{template}.haml"
      bad_luck file_name unless File.exists? file_name
     
      hash = hash_for template, :haml
      hash += hash_for "data/#{template}", :yaml if File.exists? "#{pwd}/data/#{template}.yaml"
      etag hash
      haml template.to_sym
    end
    
    def sass(template)
      file_name = "#{pwd}/#{template}.sass"
      bad_luck file_name unless File.exists? file_name

      etag hash_for(template, :sass)
      Sass.compile File.read(file_name), :syntax => :sass
    end
  
    def coffee(template)
      file_name = "#{pwd}/#{template}.coffee"
      bad_luck file_name unless File.exists? file_name
      
      etag hash_for(template, :coffee)
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
      File.expand_path(Dir.pwd)
    end
    
    def bad_luck(path)
      halt 404, "<h1>You have still to put something here.</h1><p>This is <em>#{path}</em></p><blockquote>Good luck!</blockquote>"
    end
    
    def hash_for(name, type)
      "#{name}.#{type} - " + File.mtime("#{pwd}/#{name}.#{type}").to_s
    end
    
    def extract(text, length = 80)
      words = text.gsub(/<.+?>/, "").split
      return text if words.length <= length
      words[0..(length-1)].join(" ") + "..."
    end
    
    def unicode_entities(string)
      encodings = ""
      string.codepoints do |c|
        encodings += "&##{c};"
      end
      encodings
    end
  end
  
  def self.play!
    self.run!
  end
end