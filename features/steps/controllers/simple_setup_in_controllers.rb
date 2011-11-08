#Given /^I have a simple controllers setup that prints "(.+?)"$/ do |word|
  # This should be done in a rake task!!
#  pending "Check the file in the setup has what is needed"
#  pending "Check the server is up" do
#    Environment::Setup::SimpleController.setup
#  end
#end

#When /^I get to the url defined in the controller$/ do
#  begin
#    Mecha.go Environment::Setup::SimpleController.url
#  rescue Net::HTTP::Persistent::Error => e
#    puts "Remember to start piano in the `arena` folder!"
#    puts "Otherwise there's no way to test this"
#  end
#end