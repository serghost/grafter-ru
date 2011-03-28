Feature: Editing reviews
  In order to update review
  As a user
  I want to be able to do that through an interface

  Background:
    Given these are the following cities:
      | department        | city       |
      | Moscow department | Moscow     |
    Given there is a university called "МГУ" with "Moscow University" title
    Given these are the followng reviews:
      | text                    | kind |
      | My note for university. | Bad  |
    And I am on the university page for "МГУ"
    And I follow "Reviews"
    And I follow "Edit review"

  Scenario: Updating a review
    And I fill in "Text" with "New note for this university."
    And I select "Good" from "review[kind]"
    When I press "Update Review"
    Then I should see "Review has been updated."
    And I should see "New note for this university."
    And I should not see "My note for university."

  Scenario: Updating a review with invalid attributes
    And I fill in "Text" with "New note."
    When I press "Update Review"
    Then I should see "Review has not been updated."
    And I should see "is too short (minimum is 10 characters)"
