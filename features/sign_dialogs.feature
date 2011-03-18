Feature: Sign In and Sign Up dialogs
  In order to sign in or sign up
  As a user
  I want to show up dialogs

  Background:
    Given I am on the homepage

  @javascript
  Scenario: Show Sign In dialog with JavaScript
    When I follow "Sign In"
    Then I should see "Email"
    And I should see "Password"
    And I should be on the homepage
