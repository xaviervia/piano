Feature: Make semantic switches for a class or module
  In order to make semantic development easier
  As a Ruby developer
  I want to have a simple bundled switchmaker
  
  Scenario: The var exists, and when asked in ?.. true or false
    Given the class Klass
    When I add the switch :my_switch
    Then the var :@@my_switch should be defined and false (default)
    And the method :my_switch? should be public
    And :my_switch? should return true when :my_switch called with :on
    And :my_switch? should return true when :my_switch called with :yes
    And :my_switch? should return true when :my_switch called with 1
    And :my_switch? should return true when :my_switch called with true
    And :my_switch? should return false when :my_switch called with :off
    And :my_switch? should return false when :my_switch called with :no
    And :my_switch? should return false when :my_switch called with 0
    And :my_switch? should return false when :my_switch called with false
    And :my_switch? should raise ArgumentError when called with Hash
    And :my_switch? should raise ArgumentError when called with Array
    And :my_switch? should raise ArgumentError when called with String
  
  Scenario: Adding a proc as switch
    Given the class Klass
    When I add the switch :my_switch
    And I set :my_switch to be a proc
    Then :my_switch? should return the same as the proc
 
  Scenario: Setting default
    Given the class Klass
    When I add the switch :my_switch default in true
    Then the var :@@my_switch should be defined and true
    And :my_switch? should return true