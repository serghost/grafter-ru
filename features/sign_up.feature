Feature: Signing Up
  In order to be working with a site data
  As a user
  I want to be able to sign up

  Background:
    Given I am on the homepage
    When I follow "Sign Up"

  Scenario: Signing up with valid data
    And I fill in "Email" with "yeah@yeah.com"
    And I fill in "Password" with "qwerty"
    And I press "Register"
    Then I should see "Profile"
    And I should see "Log out"
    And I am on the homepage

  Scenario: Signing up with invalid data
    And I fill in "Email" with "yeahyeahcom"
    And I fill in "Password" with ""
    And I press "Register"
    Then I should not see "Profile"
    And I should not see "Log out"
    And show me the page
    And I should see "is invalid"
    And I should see "can't be blank"
