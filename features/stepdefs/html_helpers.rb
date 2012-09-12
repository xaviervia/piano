# -*- encoding : utf-8 -*-
Given /^the haml view "(.+?)" with:$/ do |name, content|
  Fast.file.write name, content
end

When /^I go to (.+?)$/ do |path|
  get path
end

Then /^I should see "(.+?)"$/ do |text|
  last_response.body.should include text
end