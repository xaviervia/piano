require "sinatra/base"
require "haml"
require "sass"

class Piano < Sinatra::Base
  set :root, File.expand_path(Dir.pwd)
  set :views, File.expand_path(Dir.pwd)
  
  get "/" do
    try_haml :index
  end
  
  get "/:something.css" do |something|
    content_type :css
    sass something.to_sym
  end
  
  get "/:something" do |something|
    try_haml something.to_sym
  end
  
  helpers do
    def try_haml(template)
      begin
        return haml template
      rescue Exception => error
        if error.message =~ /No such file or directory/
          path = File.expand_path(Dir.pwd)
          response = "<h1>You have still to put something here.</h1><p>This is <em>#{path}/#{template.to_sym}.haml</em></p><blockquote>Good luck!</blockquote>"
          return response
        else
          raise error
        end
      end
    end
    
    def sass(template)
      begin
        dir = File.expand_path(Dir.pwd)
        data = ""
        File.open "#{dir}/#{template.to_s}.sass" do |file|
          data = file.read
        end
        return Sass.compile(data, :syntax => :sass)
      rescue Exception => error
        if error.message =~ /No such file or directory/
          path = File.expand_path(Dir.pwd)
          response = "<h1>You have still to put something here.</h1><p>This is <em>#{path}/#{template.to_s}.sass</em></p><blockquote>Good luck!</blockquote>"
          return response
        else
          raise error
        end
      end
    end
  end
  
end