Feature: Editing prices
  In order to update attributes
  As a user
  I want to be able to do that through an interface

  Background:
    Given there are the following users:
      | email             | password |
      | newbie@grafter.ru | qwerty   |
    And I am signed in as them
    Given these are the following cities:
      | department        | city       |
      | Moscow department | Moscow     |
    Given there is a university called "МГУ" with "Moscow University" title
    Given these are the following prices:
      | personal              | lesson_title | score_5 | score_4 | score_3 | test | attestation | course_work |
      | Ivanov Ivan Ivanovich | OOP    | 2000    | 1400    | 1000    | 1300 | 1000        | 3000        |
    And I am on the university page for "МГУ"
    And I am on the edit page for price with lesson "OOP" and personal "Ivanov Ivan Ivanovich"

  Scenario: Updating a price
    And I fill in "Lesson" with "Mathematics"
    And I fill in "Personal" with "Boris Borisovich Borisov"
    And I fill in "Score 5" with "200"
    And I fill in "Score 4" with "150"
    And I fill in "Score 3" with "130"
    And I fill in "Attestation" with "100"
    And I fill in "Test" with "160"
    And I fill in "Course work" with "360"
    Then I press "Update Price"
    And I should see "Price has been updated."
    And I should see "Boris Borisovich Borisov"

  Scenario: Disable a lesson and personal fields for non-moderator

  Scenario: Checking a privious values for price
    Then the "price[lesson_title]" field should contain "Oop"
    And the "price[personal]" field should contain "Ivanov Ivan Ivanovich"
    And I should not see "Revisions"

  Scenario: Viewing a price revisions
    And I follow "Log out"
    Given there are the following users:
      | email             | password | admin |
      | admin@grafter.ru  | qwerty   | true  |
    And I am signed in as them
    And I am on the edit page for price with lesson "OOP" and personal "Ivanov Ivan Ivanovich"
    And I fill in "Lesson title" with "Mathematics"
    And I fill in "Personal" with "Boris Borisovich Borisov"
    And I fill in "Score 5" with "200"
    And I fill in "Score 4" with "150"
    And I fill in "Score 3" with "130"
    And I fill in "Attestation" with "100"
    And I fill in "Test" with "160"
    And I fill in "Course work" with "360"
    And I press "Update Price"
    And I am on the university page for "МГУ"
    When I am on the edit page for price with lesson "Mathematics" and personal "Boris Borisovich Borisov"
    Then I should see "Revisions"

  Scenario: Picking a price revision

  Scenario: Deleting a current revision
