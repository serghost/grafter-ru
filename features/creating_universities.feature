Feature: Creating universities
  In order to have universities to assign prices
  As a user
  I want to create them easily

  Background:
    Given there are the following users:
      | email             | password |
      | newbie@grafter.ru | qwerty   |
    Given these are the following cities:
      | department        | city       |
      | Moscow department | Moscow     |
    And I am signed in as them
    Given I am on the homepage
    When I follow "Universities"
    And I follow "Add university"

  Scenario: Creating a university
    And I fill in "Short name" with "МГУ"
    And I fill in "Full title" with "Московский государственный университет имени М.В.Ломоносова"
    And I select "Moscow" from "university[city_id]"
    Then I press "Create University"
    And I should see "Successfully created."
    And I should see "Prices"
    And I should see "Reviews"

  Scenario: Creating a university with invalid data
    And I fill in "Short name" with "_"
    And I fill in "Full title" with "_"
    Then I press "Create University"
    And I should not see "Successfully created."
    And I should see "is too short (minimum is 2 characters)"
    And I should see "is too short (minimum is 7 characters)"

  Scenario: Creating the duplicate of university
    Given there is a university called "МГУ" with "Yet Another University" title
    And I fill in "Short name" with "МГУ"
    And I fill in "Full title" with "Yet another university"
    Then I press "Create University"
    And I should not see "Successfully created."
    And I should see "this university is already exists"
