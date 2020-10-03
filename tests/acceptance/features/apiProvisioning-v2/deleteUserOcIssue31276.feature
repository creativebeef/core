@api @provisioning_api-app-required @skipOnLDAP @skipOnOcV10 @notToImplementOnOCIS
Feature: delete users
  As an admin
  I want to be able to delete users
  So that I can remove user from ownCloud

  Background:
    Given using OCS API version "2"

  @issue-31276
  Scenario: normal user tries to delete a user
    Given these users have been created with default attributes and skeleton files:
      | username |
      | Alice    |
      | Brian    |
    When user "Alice" deletes user "Brian" using the provisioning API
    Then the OCS status code should be "401"
    And the HTTP status code should be "401"
    And user "Brian" should exist
