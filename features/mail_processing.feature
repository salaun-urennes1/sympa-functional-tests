 # Testing mail processing by Sympa
 Feature: Mail processing
 
  Background:
    Given family "test_bundle_of_lists" is created
    When I instantiate family "test_bundle_of_lists" with "initial_definition.xml"

  Scenario: Send basic email to basic list
    Given list "testbasic" has a config file
    Given sender is defined for mail template "basic_7bit" to list "testbasic"
    Given sender is imported in list "testbasic"
    When sender sends mail template "basic_7bit" to list "testbasic"
    Then sender should receive email
    
       

    
