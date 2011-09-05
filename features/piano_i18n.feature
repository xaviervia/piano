Feature: i18n
  In order to have internationalization in Piano
  As a Piano user
  I want to get it loaded and ready
  
  Scenario: Load the i18n
    Given I have installed the i18n gem
    When I require the i18n
    Then I have the I18n module in scope
    
  Scenario: Get an english translation
    Given I have the file "config/locale/en.yml"
    And I have the file "config/locale/es.yml"
    And the file "config/locale/en.yml" includes:
      """
      en: 
        hello:
          world: 'Hello World!'
      """
    When I load the i18ns within "config/locale"
    And I set the locale as :en
    And I run the translation with "hello.world"
    Then I should get the translated "Hello World!"
    
  Scenario: Provide a helper
    Given everything is ok
    When execute instance.t "some.text"
    Then translation should match "translation missing"