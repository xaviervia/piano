module Piano
  class Base < Sinatra::Base      
    register Sinatra::Piano
    register Sinatra::Flash
    
    # Defaults
    set :root, File.expand_path(Dir.pwd)
    set :views, File.expand_path(Dir.pwd)
    set :data, File.expand_path(Dir.pwd + "/data")
    set :etags, :on
    set :multidomain, :off
    
    class << self
      alias :run! :play!
    end    
  end
end
