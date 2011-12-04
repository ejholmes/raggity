Feature:
  In order to user the application
  As an unauthenticated user
  I want to be able to login

  Scenario: A user visits the home page and logs in
    Given the following user exists:
      | email         | password |
      | alice@foo.com | password |
    When I visit the home page
    And I fill in "Email" with "alice@foo.com"
    And I fill in "Password" with "password"
    And I click "Sign in"
    Then I should be logged in

  Scenario: A user visits the home page and attempts to login with a bad password
    Given the following user exists:
      | email         | password |
      | alice@foo.com | password |
    When I visit the home page
    And I fill in "Email" with "alice@foo.com"
    And I fill in "Password" with "passwd"
    And I click "Sign in"
    Then I should see "Invalid email or password"

  Scenario: A user visits the home page and attempts to login with a bad username
    Given the following user exists:
      | email         | password |
      | alice@foo.com | password |
    When I visit the home page
    And I fill in "Email" with "alce@foo.com"
    And I fill in "Password" with "password"
    And I click "Sign in"
    Then I should see "Invalid email or password"
