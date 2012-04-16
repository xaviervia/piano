require "metafun/delegator"

extend Metafun::Delegator

module TheModule
  @@local_var = "Hello delegation"
  def self.take_action
    @@local_var
  end
end

delegate TheModule, :take_action

puts take_action  # At this stage, this is exactly the same
                  # as calling TheModule.take_action