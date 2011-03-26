Feature: Deleting universities
  In order to remove universities
  As an moderator
  I want to click a button and delete them

  Scenario: Deleting a university
    Given these are the following cities:
      | department        | city       |
      | Moscow department | Moscow     |
    Given there is a university called "МГУ" with "Moscow University" title
    And I am on the university page for "МГУ"
    When I follow "Delete"
    Then I should see "University has been deleted."
