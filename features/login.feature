Feature:
  In order to user the application
  As an unauthenticated user
  I want to be able to login

  Scenario: A user visits the home page and logs in
    Given I am an unauthenticated user
    When I visit the home page
    And I fill in "username" with "alice@foo.com"
    And I fill in "password" with "password"
    And I click "login"
    Then I should be logged in

  Scenario: A user visits the home page and attempts to login with a bad password
    Given I am an unauthenticated user
    When I visit the home page
    And I fill in "username" with "alice@foo.com"
    And I fill in "password" with "passwd"
    And I click "login"
    Then I should see "invalid username or password"

  Scenario: A user visits the home page and attempts to login with a bad username
    Given I am an unauthenticated user
    When I visit the home page
    And I fill in "username" with "alce@foo.com"
    And I fill in "password" with "password"
    And I click "login"
    Then I should see "invalid username or password"
