Feature: Search for things on Google and see results.

Scenario: See "Dog" when I search for "puppies"
  When I search for "puppies"
  Then I should see "Dog"
