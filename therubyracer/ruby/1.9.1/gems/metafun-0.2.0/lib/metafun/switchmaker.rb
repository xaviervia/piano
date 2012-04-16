module Metafun
  module Switchmaker
    def switch argument, default = false
      class_variable_set :"@@#{argument}", default
      class_eval <<-STRING
        def self.#{argument}?
          return @@#{argument}.call if @@#{argument}.kind_of? Proc
          return @@#{argument}
        end
        
        def self.#{argument} the_arg
          if the_arg.kind_of? Proc
            @@#{argument} = the_arg
          else
            case the_arg
              when :on;     @@#{argument} = true
              when :yes;    @@#{argument} = true
              when 1;       @@#{argument} = true
              when true;    @@#{argument} = true
              when :off;    @@#{argument} = false
              when :no;     @@#{argument} = false
              when 0;       @@#{argument} = false
              when false;   @@#{argument} = false
            end
          end
        end
      STRING
    end
  end
end

class Class
  include Metafun::Switchmaker
end