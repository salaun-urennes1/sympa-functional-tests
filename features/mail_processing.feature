 # Testing mail processing by Sympa
 Feature: Mail processing
 
  Background:
    Given family "test_bundle_of_lists" is installed
    When I close family "test_bundle_of_lists"
     And I instantiate family "test_bundle_of_lists" with "initial_definition.xml"

  Scenario: Basic email processing
    Given list "test_basic" has a config file
     And outgoing mail is based on template "basic_7bit" for list "test_basic"
     And sender email is imported in list "test_basic"
    When I send outgoing mail
     And I wait 5 seconds
    Then sender should receive incoming mail
     And incoming mail body should match outgoing mail
    
Scenario: Basic email processing with custom subject tagging
    Given list "test_custom_subject" has a config file
     And outgoing mail is based on template "basic_7bit" for list "test_custom_subject"
     And sender email is imported in list "test_custom_subject"
    When I send outgoing mail
     And I wait 5 seconds
    Then sender should receive incoming mail
     And incoming mail "Subject" header should include "custom tag"
 

    
