Feature: Deleting reviews
  In order to remove reviews
  As a user
  I want to click a button and delete them

  Scenario:
    Given these are the following cities:
      | department        | city       |
      | Moscow department | Moscow     |
    Given there is a university called "МГУ" with "Moscow University" title
    Given these are the followng reviews:
      | text                    | kind |
      | My note for university. | Bad  |
    And I am on the university page for "МГУ"
    And I follow "Reviews"
    When I follow "Delete review"
    Then I should see "Review has been deleted."
