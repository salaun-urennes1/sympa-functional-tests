 # Testing mail processing by Sympa
 Feature: Mail processing
 
  Background:
    Given family "test_bundle_of_lists" is created
    When I close family "test_bundle_of_lists"
    When I instantiate family "test_bundle_of_lists" with "initial_definition.xml"

  Scenario: Send basic email to basic list
    Given list "testbasic" has a config file
    Given sender is defined for mail template "basic_7bit" to list "testbasic"
    Given sender is imported in list "testbasic"
    When sender sends mail template "basic_7bit" to list "testbasic"
    When I wait 5 seconds
    Then mail spool should contain sender mail
    
       

    
