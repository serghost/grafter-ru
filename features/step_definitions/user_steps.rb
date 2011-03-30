Given /^there are the following users:$/ do |table|
  table.hashes.each do |attributes|
    @user = User.create! attributes

    if attributes["admin"].present?
      @user.admin = attributes["admin"]
      @user.save
    end
  end
end

Given /^I am signed in as them$/ do
  steps(%Q{
    Given I am on the homepage
    When I follow "Sign In"
    And I fill in "Email" with "#{@user.email}"
    And I fill in "Password" with "qwerty"
    And I press "Continue"
    Then I should see "Signed in successfully."
    And I should see "Profile"
    And I should see "Log out"
  })
end
