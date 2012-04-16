module Trying
end

Given /^the class (.*?)$/ do |class_name|
  @class_name = class_name
  Trying.const_set(@class_name, Class.new)
end

When /^I add the switch :([^\s]*?)$/ do |switch_name|
  Trying.const_get(@class_name).class_eval { switch switch_name.to_sym }
end

When /^I add the switch :([^\s]*?) default in true$/ do |switch_name|
  Trying.const_get(@class_name).class_eval do
    switch switch_name.to_sym, true
  end
end

When /^I set :(.+?) to be a proc$/ do |switch_name|
  @proc = proc { true }
  Trying.const_get( @class_name ).class_variable_set(
    :"@@#{switch_name}", false )

  Trying.const_get( @class_name ).send( switch_name.to_sym, @proc )
end

Then /^:(.+?) should return the same as the proc$/ do |question_name|
  Trying.const_get( @class_name )
    .send( question_name.to_sym ).should == @proc.call
end

Then /^the var :(.*?) should be defined and false \(default\)$/ do 
  |var_name|
  
  Trying.const_get(@class_name).class_eval do
    class_variable_defined?(var_name.to_sym).should == true
    class_variable_get(var_name.to_sym).should == false
  end
end

Then /^the var :(.*?) should be defined and true$/ do 
  |var_name|
  
  Trying.const_get(@class_name).class_eval do
    class_variable_defined?(var_name.to_sym).should == true
    class_variable_get(var_name.to_sym).should == true
  end
end

Then /^:(.+?) should return true$/ do |question_name|
  Trying.const_get(@class_name).send(question_name).should == true
end

Then /^the method :(.+?) should be public$/ do |method_name|
  Trying.const_get(@class_name).class_eval do
    public_class_method(method_name.to_sym)
  end
end

Then /^:(.+?) should return (.*?) when :(.+?) called with :(.+?)$/ do
  |question_name, return_value, switch_name, argument|
  
  Trying.const_get(@class_name).class_eval { switch switch_name.to_sym }

  value = true    if return_value == "true"
  value = false   if return_value == "false"
 
  # Set it in true if expecting a false
  if value == false
    Trying.const_get(@class_name).class_eval do
      class_variable_set :"@@#{switch_name}", true
    end
  end

  Trying.const_get(@class_name).send switch_name.to_sym, argument.to_sym
  Trying.const_get(@class_name).send(question_name).should == value
end

Then /^:(.+?) should return (.*?) when :(.+?) called with 1$/ do
  |question_name, return_value, switch_name|
  
  Trying.const_get(@class_name).class_eval { switch switch_name.to_sym }

  Trying.const_get(@class_name).send switch_name.to_sym, 1
  Trying.const_get(@class_name).send(question_name).should == true
end

Then /^:(.+?) should return (.*?) when :(.+?) called with true$/ do
  |question_name, return_value, switch_name|
  
  Trying.const_get(@class_name).class_eval { switch switch_name.to_sym }

  Trying.const_get(@class_name).send switch_name.to_sym, true
  Trying.const_get(@class_name).send(question_name).should == true
end

Then /^:(.+?) should return (.*?) when :(.+?) called with 0$/ do
  |question_name, return_value, switch_name|
  
  Trying.const_get(@class_name).class_eval { switch switch_name.to_sym }

  Trying.const_get(@class_name).send switch_name.to_sym, 0
  Trying.const_get(@class_name).send(question_name).should == false
end

Then /^:(.+?) should return (.*?) when :(.+?) called with false$/ do
  |question_name, return_value, switch_name|
  
  Trying.const_get(@class_name).class_eval { switch switch_name.to_sym }

  Trying.const_get(@class_name).send switch_name.to_sym, false
  Trying.const_get(@class_name).send(question_name).should == false
end

Then /^:(.+?) should raise ArgumentError when called with Hash$/ do 
  |switch_name|
  
  expect {
    Trying.const_get(@class_name).send switch_name.to_sym, Hash.new
  }.to raise_error( ArgumentError )
end

Then /^:(.+?) should raise ArgumentError when called with Array$/ do 
  |switch_name|
  
  expect {
    Trying.const_get(@class_name).send switch_name.to_sym, Array.new
  }.to raise_error( ArgumentError )
end

Then /^:(.+?) should raise ArgumentError when called with String$/ do 
  |switch_name|
  
  expect {
    Trying.const_get(@class_name).send switch_name.to_sym, String.new
  }.to raise_error( ArgumentError )
end