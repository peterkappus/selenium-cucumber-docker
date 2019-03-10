Feature: Search for things on Google and see results.

Scenario: See related words when searching.
  When I search for "puppies"
  Then I should see "dog"

  
Scenario: Don't see unrelated words when searching.
  When I search for "dachshund"
  Then I should NOT see "fish"
