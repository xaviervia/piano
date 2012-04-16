Feature: Delegate Module or Class methods to main Object
  In order to create DSLs from modules
  As a gem developer
  I want to delegate their methods to main Object
   
  Scenario: Delegate into a class a method that receives a block
    Given a module with the :with_block method that receives a block and returns its result
    And I included the Delegator in the class
    When I delegate :with_block into the class
    And I execute :with_block in the class sending a block that returns "Hello Block!"
    Then I should get "Hello Block!"
    
  Scenario: Check that delegated method have local access to module properties
    Given a module with the :local_check method that returns @@local_var
    And the module @@local_var = "I am a local var, cheers!"
    And I included the Delegator in the class
    When I delegate :local_check into the class
    And I execute :local_check in the class
    Then I should get "I am a local var, cheers!"
