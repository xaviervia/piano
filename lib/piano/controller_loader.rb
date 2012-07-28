module Piano
  # Handler of .controller files loading
  class ControllerLoader
    def self.folder path
      recursive path do |item|
        load item
      end
    end

    # Iterates recursively over the path and calls the block
    # with each newfound file
    def self.recursive path, &block
      files = []
      Dir.new(File.expand_path(path)).each do |file|
        if File.directory? "#{path}/#{file}"
          unless file == '..' or file == '.'
            recursive "#{path}/#{file}" do |item|
              files << "#{item}"
            end
          end
        elsif file.end_with? '.controller'
          files << "#{path}/#{file}"
        end
      end
      files.each { |item| block.call(item) }
    end
  end
end
