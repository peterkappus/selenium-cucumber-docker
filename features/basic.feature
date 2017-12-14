
Feature: Do some really basic stuff.

Scenario: See "Dog" when I search for "puppies"
  When I visit "/"
  And I fill in "lst-ib" with "puppies"
  And I click "Google Search"
  Then I should see "Dog"
  #And I debug
