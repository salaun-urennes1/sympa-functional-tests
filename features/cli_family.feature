 # Somehow I don't see this replacing the other tests this module has...
 Feature: List family management
 
  Background:
    Given family "testfamily" is installed

  Scenario: Instantiate list family
    Given family "testfamily" is defined
    When I instantiate family "testfamily" with "initial_definition.xml"
    Then list "testlist1" should have a config file
     And list "testlist1" homepage title should contain "This is my list"

  Scenario: Modify list family
    Given family "testfamily" is defined
    When I modify list in family "testfamily" with "modifylist_definition.xml"
    Then list "testlist1" homepage title should contain "New list subject"
       
  Scenario: Add list to family
    Given family "testfamily" is defined
      And I remove list "testlist2" existing directory
    When I add list to family "testfamily" with "addlist_definition.xml"
    Then list "testlist2" should have a config file
     And list "testlist2" homepage title should contain "This is my list"

  Scenario: Close list from family
    Given family "testfamily" is defined
     And list "testlist2" has a config file
    When I close list "testlist2" from family "testfamily"
    Then list "testlist2" config file should contain "status family_closed"
    
