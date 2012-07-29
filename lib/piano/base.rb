module Piano
  class Base < Sinatra::Base
    register Sinatra::Piano
    register Sinatra::Flash

    Compass.configuration do |config|
      config.project_path = File.expand_path(Dir.pwd)
      config.sass_dir = File.expand_path(Dir.pwd)
    end

    # Defaults
    set :root, File.expand_path(Dir.pwd)
    set :views, File.expand_path(Dir.pwd)
    set :sass, Compass.sass_engine_options
    set :data, File.expand_path("#{Dir.pwd}/data")
    set :etags, :on
    set :multidomain, :off

    def self.play!
      self.run!
    end
  end
end
