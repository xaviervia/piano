Feature: `controllers` folder autoloading
  In order to make controllers development easier
  As a Piano developer
  I want to have Piano automatically loading them

Scenario: Simple setup in controllers
  Given I have a valid controller that outputs some text
  When I get to the url defined in the controller
  Then I should see the demo text

Scenario: Files ending in other than .controller are not loaded
  Given I have an invalid extension controller that outputs some text
  When I get to the url defined in a file not controller
  Then I shold not see the demo text