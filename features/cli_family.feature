 # Somehow I don't see this replacing the other tests this module has...
 Feature: Instantiate a list family 
 
  Background:
    Given family "testfamily" is created

  Scenario: Instantiate list family
    Given family "testfamily" is defined
    When I instantiate family "testfamily" with "initial_definition.xml"
    Then list "testlist1" should have a config file
    Then list "testlist1" should have a web page
    
