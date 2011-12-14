require "polyglot"

module Piano
  # Controller loader especifically for polyglot
  class PolyglotControllerLoader
    # Loads the file, no more settings for the moment
    def self.load filename, options = nil, &block
      Kernel.eval File.read filename
    end
  end

  # Handler of .controller files loading
  class ControllerLoader
    def self.folder path
      $LOAD_PATH << Dir.pwd
      recursive path do |item|
        require item
      end
    end
    
    # Iterates recursively over the path and calls the block
    # with each newfound file
    def self.recursive path, &block
      files = []
      Dir.new(File.expand_path(path)).each do |file|
        if File.directory? "#{path}/#{file}"
          recursive "#{path}/#{file}" do |item|
            files << "#{item}"
          end unless file == ".." or file == "."
        elsif file.end_with? ".controller"
          files << "#{path}/#{file[0..-12]}"
        end
      end
      files.each { |item| block.call(item) }
    end
  end
end

Polyglot.register "controller", Piano::PolyglotControllerLoader
