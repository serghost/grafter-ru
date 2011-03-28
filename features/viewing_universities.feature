Feature: Viewing universities
  In order to view a university
  As a user
  I want to be able to see a list of available universities

  Scenario: Listing all universities
    Given these are the following cities:
      | department        | city       |
      | Moscow department | Moscow     |
    Given there is a university called "МГУ" with "Moscow University" title
    And I am on the homepage
    And I follow "Universities"
    When I follow "МГУ"
    Then I should be on the university page for "МГУ"
