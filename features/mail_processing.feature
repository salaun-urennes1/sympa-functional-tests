 # Testing mail processing by Sympa
 Feature: Mail processing
 
  Background:
    Given family "test_bundle_of_lists" is created
    When I close family "test_bundle_of_lists"
    When I instantiate family "test_bundle_of_lists" with "initial_definition.xml"

  Scenario: Send basic email to basic list
    Given list "testbasic" has a config file
    Given outgoing mail is based on template "basic_7bit" for list "testbasic"
    Given sender email is imported in list "testbasic"
    When I send outgoing mail
    When I wait 5 seconds
    Then sender should receive incoming mail
    Then incoming mail body should match outgoing mail
    
       

    
