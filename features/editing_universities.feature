Feature: Editing university
  In order to update information
  As a admin
  I want to be able to do that through an interface

  Background:
    Given these are the following cities:
      | department        | city       |
      | Moscow department | Moscow     |
      | Moscow department | Podolsk    |
    Given there is a university called "МГУ" with "Moscow University" title
    Given there are the following users:
      | email             | password | admin |
      | newbie@grafter.ru | qwerty   | true  |
    And I am signed in as them
    And I am on the university page for "МГУ"
    And I follow "Edit"

  Scenario: Updating a university
    And I fill in "Short name" with "Yeah"
    And I fill in "Full title" with "New university title"
    And I select "Podolsk" from "university[city_id]"
    Then I press "Update University"
    And I should see "University has been updated."
    And I should see "Yeah (Podolsk)"
    And I should see "New university title"
    And I should see "Prices"

  Scenario: Updating a university with invalid attributes
    And I fill in "Short name" with "_"
    And I fill in "Full title" with "_"
    Then I press "Update University"
    And I should not see "University has been updated."
