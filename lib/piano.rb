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

class Piano < Sinatra::Base

  class AllButPattern
    Match = Struct.new(:captures)

    def initialize(except)
      @except   = except
      @captures = Match.new([])
    end

    def match(str)
      @captures unless @except === str
    end
  end

  def self.all_but(pattern)
    AllButPattern.new(pattern)
  end
  
  set :root, File.expand_path(Dir.pwd)
  set :views, File.expand_path(Dir.pwd)
  set :etags, :on
  set :etags?, Proc.new { settings.etags == :on }
  
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
  
  get all_but(%r{/finetuner(:.+)$}) do 
    something = request.path[1..(request.path.length-1)]
    @data = data_for something
    try_haml something
  end
  
  helpers do
    def try_haml(template)
      file_name = "#{pwd}/#{template}.haml"
      bad_luck file_name unless File.exists? file_name
     
      if settings.etags?
        hash = hash_for template, :haml
        hash += hash_for "data/#{template}", :yaml if File.exists? "#{pwd}/data/#{template}.yaml"
        etag hash
      end
      haml template.to_sym
    end
    
    def sass(template)
      file_name = "#{pwd}/#{template}.sass"
      bad_luck file_name unless File.exists? file_name

      etag hash_for(template, :sass) if settings.etags?
      Sass.compile File.read(file_name), :syntax => :sass
    end
  
    def coffee(template)
      file_name = "#{pwd}/#{template}.coffee"
      bad_luck file_name unless File.exists? file_name
      
      etag hash_for(template, :coffee) if settings.etags?
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
  end
  
  def self.play!
    self.run!
  end
end