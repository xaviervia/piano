module Sinatra

  # Piano was originally though as a Sinatra extension
  # That's why the code was defined here
  module Piano

    # Replacemente for :try_haml, :try_slim, :sass & :coffee. Agnostic
    # Work in progress
    def fetch(*args)
      resource = args.shift

      unless type = args.shift
        [:haml, :slim].each do |t|
          file_name = "#{settings.views}/#{resource}.#{t}"
          if File.exists?(file_name)
            type = t and break
          end
        end
      end

      return bad_luck("#{settings.views}/#{resource}.haml/slim") unless type

      if etags?
        if [:haml, :slim].include? type
          hash = hash_for resource, type
          if File.exists? "#{settings.views}/#{settings.data}/#{resource}.yaml"
            hash += hash_for "#{settings.data}/#{resource}", :yaml
          end

          etag hash
        else
          etag hash_for(resource, type)
        end
      end

      send type, resource.to_sym, *args # Send the template to Sinatra to take care of it
    end

    # Loads and parses the YAML data from the data directory
    def data_for(template)
      file_name = "#{settings.data}/#{template}.yaml"
      YAML.load_file(file_name) if File.exists?(file_name)
    end

    # Sugar: formats a css stylesheet <link /> tag with the input
    #def style(path, more = '')
    #  "<link rel='stylesheet' type='text/css' href='#{path}' #{more} />"
    #end

    # Sugar: formats a javascript <script> tag with the input
    #def script(path, more = '')
    #  "<script type='text/javascript' src='#{path}' #{more} ></script>"
    #end

    # Fails. Shouts a 404 response and prints hints
    #
    # If Piano is running in production mode, prints a plain 404 html
    # or, if a 404.haml or 404.slim exists in the :views directory, returns it
    def bad_luck(path)
      content_type :html
      if settings.environment == :production
        if File.exists? "#{settings.views}/404.haml"
          @data = data_for "404"
          halt 404, haml(:"404")
        elsif File.exists? "#{settings.views}/404.slim"
          @data = data_for "404"
          halt 404, slim(:"404")
        else
          halt 404, '<h1>404 - Not Found</h1><p>Piano has found nothing in this address</p>'
        end
      else
        halt 404, "<h1>You have still to put something here.</h1><p>This is <em>#{path}</em></p><blockquote>Good luck!</blockquote>"
      end
    end

    # Builds a hash for a file within the :views directory
    # Note: I feel like this functionality should be private
    def hash_for(name, type)
      "#{name}.#{type} - #{File.mtime("#{settings.views}/#{name}.#{type}")}"
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
      words = text.gsub(/<.+?>/, '').split
      return text if words.length <= length
      words[0..(length-1)].join(' ') + '...'
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
      words = text.gsub(/<.+?>/, '').gsub(' ', '-').downcase.gsub(/[^a-z0-9\-]/, '').split('-')
      words[0..(length-1)].join('-')
    end

    # Shorthand to settings.etags == :on
    def etags?
      if settings.respond_to? :etags
        settings.etags == :on
      else
        true
      end
    end

  end

  register Piano
end
