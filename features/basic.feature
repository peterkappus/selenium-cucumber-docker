Feature: Search for things on Google and see results.

Scenario Outline: See related words when searching.
  When I search for "<primary_term>"
  Then I should see "<secondary_term>"

  Examples:
  | primary_term | secondary_term |
  | Puppies  |   Dog  |
  | Kittens  |  Cat   |
  | Guppies |  Fish  |
