 # Testing mail processing by Sympa
 Feature: Mail processing
 
  Background:
    Given family "test_bundle_of_lists" is created

  Scenario: Send basic email to basic list
    Given list "testbasic" has a config file
    Given sender is defined
    Given sender is imported in list "testbasic"
    Given email template is "basic_7bit"
    When sender sends email to list "testpublic"
    Then sender should receive email
    
       

    
