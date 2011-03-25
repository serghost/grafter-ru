Feature: Signing in
  In order to use the site
  As a user
  I want to be able to sing in

  Scenario: Signing in as just user
    Given there are the following users:
      | email             | password |
      | newbie@grafter.ru | qwerty   |
    And I am signed in as them
    Then I should not see "Admin"
    And I should not see "Moderate"
