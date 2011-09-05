Given /I have installed the (.*?) gem$/ do |gem|
  Gem.available? gem
end

When /I require the (.*?)$/ do |file|
  Piano.should be_a(Class)
end

Then /I have the (.*?) module in scope/ do |class_name|
  klass = Module.const_get class_name
  klass.should be_a(Module)
end

Given /I have the file "([^"]*)"$/ do |file_path|
  @base_path = File.expand_path("../../../", __FILE__)
  file_name = "#{@base_path}/#{file_path}"
  File.should exist(file_name)
end

Given /the file "([^"]*)" includes:$/ do |file_path, content|
  file_content = File.read "#{@base_path}/#{file_path}"
  file_content.should == content
end

When /I load the i18ns within "([^"]*)"/ do |folder|
  Piano.i18n_path = folder
  Piano.i18n!
end

When /I set the locale as :(.*)/ do |locale_string|
  I18n.locale = locale_string.to_sym
end

When /I run the translation with "([^"]*)"/ do |key|
  @translation = I18n.translate key
end

Then /I should get the translated "([^"]*)"/ do |translated|
  @translation.should == translated
end

Given /everything is ok/ do; end

When /execute instance.t "([^"]*)"/ do |text|
  obj = Object.new
  obj.extend Sinatra::Piano::Helpers
  @translation = obj.t text
end

Then /translation should match "([^"]*)"/ do |text|
  @translation.should match(Regexp.new(text))
end