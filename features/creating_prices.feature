Feature: Creating prices
  In order to assign prices into university
  As a user
  I want to create them easily

  Background:
    Given these are the following cities:
      | department        | city       |
      | Moscow department | Moscow     |
    Given there is a university called "МГУ" with "Moscow University" title
    And I am on the university page for "МГУ"

  Scenario: Creating a price
    When I follow "Add price"
    And I fill in "Lesson" with "Mathematics"
    And I fill in "Personal" with "Ivanov Ivan Ivanovich"
    And I fill in "Score 5" with "2000"
    And I fill in "Score 4" with "1500"
    And I fill in "Score 3" with "1300"
    And I fill in "Attestation" with "1000"
    And I fill in "Test" with "1600"
    And I fill in "Course work" with "3600"
    Then I press "Create Price"
    And I should see "Price has been created."

  Scenario: Creating a price with invalid attributes
    When I follow "Add price"
    And I fill in "Lesson" with "!_"
    And I fill in "Score 5" with "two"
    And I fill in "Attestation" with "#"
    Then I press "Create Price"
    And I should see "Price has not been created."
