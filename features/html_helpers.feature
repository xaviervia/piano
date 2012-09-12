Feature: HTML Helpers tryout
  In order to make html dev easier
  As a web developer
  I want to have a share of helpers

Scenario: Script tag helper
  Given the haml view "test/index.haml" with:
  """
  !!! 5
  %html
    %head
      = script 'jquery.js'
  """
  When I go to /test/index
  Then I should see "src='jquery.js'"

Scenario: Style tag helper
  Given the haml view "test/index.haml" with:
  """
  !!! 5
  %html
    %head
      = style 'app.css'
  """
  When I go to /test/index
  Then I should see "href='app.css'"

Scenario: Style helper with text media query
  Given the haml view "test/index.haml" with:
  """
  !!! 5
  %html
    %head
      = style 'app.css', "media='screen'"
  """
  When I go to /test/index
  Then I should see "href='app.css' media='screen'"