@api @provisioning_api-app-required @skipOnLDAP
@skipOnOcV10 @notToImplementOnOCIS @issue-31276
Feature: get user
  As an admin, subadmin or as myself
  I want to be able to retrieve user information
  So that I can see the information

  Background:
    Given using OCS API version "2"

  Scenario: a normal user tries to get information of another user
    Given these users have been created with default attributes and skeleton files:
      | username         |
      | brand-new-user   |
      | another-new-user |
    When user "another-new-user" retrieves the information of user "brand-new-user" using the provisioning API
    Then the OCS status code should be "401"
    And the HTTP status code should be "401"
    And the API should not return any data

  Scenario: normal user tries to get other users
    Given these users have been created with default attributes and skeleton files:
      | username         |
      | brand-new-user   |
      | another-new-user |
    When user "brand-new-user" gets the list of all users using the provisioning API
    Then the OCS status code should be "401"
    And the HTTP status code should be "401"
    And the API should not return any data
