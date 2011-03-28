Feature: Viewing reviews
  In order to view a review
  As a user
  I want to be able to see a list of reviews

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
    And I should see "My note for university."
