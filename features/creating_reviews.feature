Feature: Creating reviews
  In order to comment the picked university
  As a user
  I want to be able to comment a university

  Background:
    Given these are the following cities:
      | department        | city       |
      | Moscow department | Moscow     |
    Given there is a university called "МГУ" with "Moscow University" title
    And I am on the university page for "МГУ"
    And I follow "Reviews"
    And I follow "Create review"

  Scenario: Creating a review
    When I select "Good" from "review[kind]"
    And I fill in "Text" with "My note for university."
    And I press "Create Review"
    Then I should see "Review has been created."
    And I should see "My note for university."

  Scenario: Creating a review with invalid data
    And I fill in "Text" with "_#_"
    And I press "Create Review"
    Then I should see "Review has not been created."
    And I should see "is too short (minimum is 10 characters)"
