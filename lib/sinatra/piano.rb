module Sinatra
  
  # Piano was originally though as a Sinatra extension
  # That's why the code was defined here
  module Piano
    
    # Like Sinatra's/Tilt's `haml`, but adds etags and
    # returns a 404 with some hints if the haml is not found
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
    
    # Loads and parses a `sass` template from the :views directory.
    # Adds an etag if `etags?` is enabled and returns 404 and hints
    # if it can't find the .sass file.
    def sass(template)
      file_name = "#{pwd}/#{template}.sass"
      bad_luck file_name unless File.exists? file_name

      etag hash_for(template, :sass) if etags?
      Sass.compile File.read(file_name), :syntax => :sass
    end
  
    # Loads and parses a `coffee-script` template from the :views
    # directory.
    # Adds an etag if `etags?` is enabled and returns 404 and hints
    # if it can't find the .coffee file.
    def coffee(template)
      file_name = "#{pwd}/#{template}.coffee"
      bad_luck file_name unless File.exists? file_name
      
      etag hash_for(template, :coffee) if etags?
      CoffeeScript.compile(File.read(file_name))
    end
    
    # Loads and parses the YAML data from the data directory
    def data_for(template)
      file_name = "#{settings.data}/#{template}.yaml"
      YAML.load_file(file_name) if File.exists?(file_name)
    end
    
    # Sugar: formats a css stylesheet <link /> tag with the input
    def style(path)
      "<link rel='stylesheet' type='text/css' href='#{path}' />"
    end
    
    # Sugar: formats a javascript <script> tag with the input
    def script(path)
      "<script type='text/javascript' src='#{path}'></script>"
    end
    
    # Returns the path to the :views directory
    def pwd
      settings.views
    end
    
    # Fails. Shouts a 404 response and prints hints
    #
    # If Piano is running in production mode, prints a plain 404 html
    # or, if a 404.haml exists in the :views directory, returns it
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
    
    # Builds a hash for a file within the :views directory
    # Note: I feel like this functionality should be private
    def hash_for(name, type)
      "#{name}.#{type} - " + File.mtime("#{pwd}/#{name}.#{type}").to_s
    end
    
    # Makes an extract out of the given text with the default length
    # of 80 words
    # 
    # If an integer is passed as the second argument, the length 
    # of the result is adjusted properly:
    #   
    #   extract "Hello World! Too much text is inconvenient", 2
    #
    # returns
    # 
    #   => "Hello World!..."
    #
    def extract(text, length = 80)
      words = text.gsub(/<.+?>/, "").split
      return text if words.length <= length
      words[0..(length-1)].join(" ") + "..."
    end
    
    # Returns a url-friendly version of the given link, with a
    # default maximum of 5 words. 
    # `link` strips any non-letter or special character, downcases the
    # string and replaces whitespace with "-"
    # For example:
    #
    #   link "This is a special text! This won't be shown"
    #
    # returns
    #
    #   => "this-is-a-special-text"
    #
    # You can specify a word length in the second argument.
    def link(text, length = 5)
      words = text.gsub(/<.+?>/, "").gsub(" ", "-").downcase.gsub(/[^a-z0-9\-]/, "").split("-")
      words[0..(length-1)].join("-")
    end
    
    # Shorthand to settings.etags == :on
    def etags?
      if settings.respond_to? :etags
        settings.etags == :on
      else 
        true
      end
    end
    
    # Non implemented yet
    def t(key)
      I18n.translate key
    end
  end
  
  register Piano
end
