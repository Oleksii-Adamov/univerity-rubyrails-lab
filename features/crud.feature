Feature: CRUD
  Background:
    Given I cleared database
  Scenario: Baggage Valid Create
    When I create baggage:
      | num | 1 |
      | weight | 25.0 |
    Then in database should be baggage:
      | num | 1 |
      | weight | 25.0 |
    And I should see "Baggage"
    And I should see "Number = 1"
    And I should see "Weight = 25.0"
  Scenario: Unable to create baggage with negative num
    When I create baggage:
      | num | -1 |
      | weight | 25.0 |
    Then I should see "Number must be greater than or equal to 0"
  Scenario: Unable to create baggage with negative weight
    When I create baggage:
      | num | 1 |
      | weight | -25.0 |
    Then I should see "Weight must be greater than or equal to 0"
  Scenario: See all baggages
    Given I have baggage:
      | num | 1 |
      | weight | 25.0 |
    And I have baggage:
      | num | 2 |
      | weight | 20.3 |
    When I execute "all_baggage"
    And I should see "Number = 1, Weight = 25.0"
    And I should see "Number = 2, Weight = 20.3"
  Scenario: Update
    Given I have baggage:
      | num | 1 |
      | weight | 25.0 |
    When I update baggage:
      | num | 1 |
      | weight | 25.0 |
    And I update baggage to:
      | num | 4 |
      | weight | 40.0 |
    Then in database should be baggage:
      | num | 4 |
      | weight | 40.0 |
    And I should see "Baggage"
    And I should see "Number = 4"
    And I should see "Weight = 40.0"
  Scenario: Unable to update baggage with negative num
    Given I have baggage:
      | num | 1 |
      | weight | 25.0 |
    When I update baggage:
      | num | 1 |
      | weight | 25.0 |
    And I update baggage to:
      | num | -4 |
      | weight | 40.0 |
    Then I should see "Number must be greater than or equal to 0"
  Scenario: Unable to update baggage with negative weight
    Given I have baggage:
      | num | 1 |
      | weight | 25.0 |
    When I update baggage:
      | num | 1 |
      | weight | 25.0 |
    And I update baggage to:
      | num | 4 |
      | weight | -40.0 |
    Then I should see "Weight must be greater than or equal to 0"
  Scenario: Delete
    Given I have baggage:
      | num | 1 |
      | weight | 25.0 |
    When I delete baggage:
      | num | 1 |
      | weight | 25.0 |
    Then in database should not be baggage:
      | num | 1 |
      | weight | 25.0 |