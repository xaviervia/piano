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
    
  end
end

Polyglot.register "controller", Piano::PolyglotControllerLoader