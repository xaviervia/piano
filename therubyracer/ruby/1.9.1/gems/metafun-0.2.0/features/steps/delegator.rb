# Given
Given /a module with the :(.+?) method which returns "(.+?)"$/ do |method, what|
  @the_module = Module.new
  @the_module.module_eval "def self.#{method}; return '#{what}'; end"
end

Given /a module with the :with_block method that receives a block and returns its result/ do
  @the_module = Module.new do
    def self.with_block(&block)
      return yield block
    end
  end
end

Given /a module with the :local_check method that returns @@local_var/ do
  @the_module = Module.new do
    def self.local_check
      @@local_var
    end
  end
end

Given /the module @@local_var = "(.+?)"/ do |text|
  @the_module.module_eval "@@local_var = '#{text}'"
end

Given /I included the Delegator in the class/ do 
  @the_class = Class.new
  @the_class.extend Metafun::Delegator
end

Given /I included the Delegator in the object/ do
  @the_object = Object.new
  @the_object.extend Metafun::Delegator
end

# When
When /I delegate :(.+?) into the class/ do |method_name|
  @the_class.delegate @the_module, method_name.to_sym
end

When /I delegate :(.+?) into the object/ do |method_name|
  @the_object.delegate @the_module, method_name.to_sym
end

When /I execute :(.+?) in the class$/ do |method_name|
  @the_result = @the_class.send method_name.to_sym
end

When /I execute :(.+?) in the object$/ do |method_name|
  @the_result = @the_object.send method_name.to_sym
end

When /I execute :(.+?) in the class sending a block that returns "(.+?)"$/ do |method_name, return_value|
  @the_result = @the_class.send method_name.to_sym do return_value end
end

When /I execute :(.+?) in the object sending a block that returns "(.+?)"$/ do |method_name, return_value|
  @the_result = @the_object.send method_name.to_sym do return_value end
end

# Then
Then /I should get "(.+?)"$/ do |result|
  @the_result.should == result
end