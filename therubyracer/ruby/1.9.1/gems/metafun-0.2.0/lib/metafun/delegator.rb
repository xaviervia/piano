module Metafun
  module Delegator
    def delegate(target, *methods)
      methods.each do |method|
        self.class.send :define_method, method do |*a, &b|
          target.send method, *a, &b
        end
      end
    end
  end
end

class Object
  include Metafun::Delegator
end
