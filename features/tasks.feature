Feature: Tasks
  Background: Test database
    Given I cleared database
    And I have baggage:
      | num | 1 |
      | weight | 25.0 |
    And I have baggage:
      | num | 2 |
      | weight | 20.3 |
    And I have baggage:
      | num | 2 |
      | weight | 20.0 |
    And I have baggage:
      | num | 3 |
      | weight | 30.0 |
  Scenario: Task A
    When I execute "a_task"
    Then I should see "Not found"
  Scenario: Task B
    When I execute "b_task"
    Then I should see "Number of passangers, that have more than two things = 1"
    And  I should see "Number of passangers, that have more than mean number of things = 1"
  Scenario: Task C
    When I execute "c_task"
    Then in database should be baggage:
      | num | 2 |
      | weight | 20.3 |
    And in database should be baggage:
      | num | 2 |
      | weight | 20.0 |
    And I should see "True"
  Scenario: Task D
    When I execute "d_task"
    Then I should see "Baggage"
    And I should see "Number = 3"
    And I should see "Weight = 30"
  Scenario: Task E
    When I execute "e_task"
    Then I should see "Baggage"
    And I should see "Number = 1"
    And I should see "Weight = 25"
