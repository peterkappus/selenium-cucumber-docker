
Feature: Do some really basic stuff.

Scenario: See "Dog" when I search for "puppies"
  When I visit "/"
  And I fill in "lst-ib" with "puppies"
  And I wait 1 second
  #And I debug
  And I click on "Google Search" button
  Then I should see "Dog"
