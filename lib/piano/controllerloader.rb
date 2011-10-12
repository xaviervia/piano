require "polyglot"

class Piano
  class ControllerLoader
    def self.load filename, options = nil, &block
      Kernel.eval File.read filename
    end
  end
end

Polyglot.register "controller", Piano::ControllerLoader