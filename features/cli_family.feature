 # Somehow I don't see this replacing the other tests this module has...
 Feature: List family management
 
  Background:

  Scenario: Instantiate list family
    Given family "testfamily" is created
    When I instantiate family "testfamily" with "initial_definition.xml"
    Then list "testlist1" should have a config file
    Then list "testlist1" homepage title should contain "This is my list"
       
  Scenario: Add list to family
    Given family "testfamily" is defined
    When I add list to family "testfamily" with "addlist_definition.xml"
    Then list "testlist2" should have a config file
    Then list "testlist2" homepage title should contain "This is my list"

  Scenario: Close list from family
    Given family "testfamily" is defined
    Given list "testlist2" has a config file
    When I close list "testlist2" from family "testfamily"
    # comment exprimer un not sans réécrire les steps ?
    Then list "testlist2" config file should contain "status family_closed"
    
