Feature: Account Creation
    As a human
    So that I can start using OpenHouse
    I want to create an OpenHouse account
Scenario: Human can create an account with an unused username
    Given I am on the home page
    When I follow "Create New Account"
    And I fill in "Username" with "Dave101"
    And I fill in "Password" with "12345"
    And I fill in "Full Name" with "Dave Smith"
    And I fill in "E-Mail" with "dave101@gmail.com"
    And I fill in "Credit Card" with "12345678"
    Then I press "Submit"
    Then I should see "Account Dave101 was successfully created."
    And account "Dave101" should exist

Scenario: Human cannot create an account with a used username
    Given account "Dave101" exists
    And I am on the home page
    When I follow "Create New Account"
    And I fill in "Username" with "Dave101"
    And I fill in "Password" with "12345"
    And I fill in "Full Name" with "Dave Smith"
    And I fill in "E-Mail" with "dave101@gmail.com"
    And I fill in "Credit Card" with "12345678"
    Then I press "Submit"
    Then I should see "Username Dave101 already taken."
    And account "Dave101" should not exist
