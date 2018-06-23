 # Testing mail processing by Sympa
 Feature: Mail processing
 
  Background:
    Given family "test_bundle_of_lists" is installed
    When I close family "test_bundle_of_lists"
    When I instantiate family "test_bundle_of_lists" with "initial_definition.xml"

  Scenario: Basic email processing
    Given list "test_basic" has a config file
    Given outgoing mail is based on template "basic_7bit" for list "test_basic"
    Given sender email is imported in list "test_basic"
    When I send outgoing mail
    When I wait 5 seconds
    Then sender should receive incoming mail
    Then incoming mail body should match outgoing mail
    
Scenario: Basic email processing with custom subject tagging
    Given list "test_custom_subject" has a config file
    Given outgoing mail is based on template "basic_7bit" for list "test_custom_subject"
    Given sender email is imported in list "test_custom_subject"
    When I send outgoing mail
    When I wait 5 seconds
    Then sender should receive incoming mail
    Then incoming mail "Subject" header should include "custom tag"
 

    
