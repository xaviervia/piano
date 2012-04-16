require "metafun/adapter"

# Adapter should be an implementation of the Adapter Pattern, 
# conceived as a Module which acts as Adapter of its Classes, either creating
# instances in regular Classes or obtaining instances in Singletons
#
# The Adapter should allow configuration in order to set which default 
# message might be send in case the Adapter's method receives arguments
# 
# Example:
#   
#   module MyModule
#     self.extend Metafun::Adapter
#     
#     class Data
#       def greet!; "Hi!"; end
#     end
#   end
#
#   MyModule.data.greet! # => 'Hi!'
#
# Delegator and Adapter combined make for a nice kit to deploying DSLs
#
describe Metafun::Adapter do
end
