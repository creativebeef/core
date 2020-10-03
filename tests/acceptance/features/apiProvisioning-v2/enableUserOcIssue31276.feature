@api @provisioning_api-app-required @skipOnLDAP
@skipOnOcV10 @notToImplementOnOCIS @issue-31276
Feature: enable user
  As an admin
  I want to be able to enable a user
  So that I can give a user access to their files and resources again if they are now authorized for that

  Background:
    Given using OCS API version "2"

  Scenario: normal user tries to enable other user
    Given these users have been created with default attributes and skeleton files:
      | username |
      | Alice    |
      | Brian    |
    And user "Brian" has been disabled
    When user "Alice" tries to enable user "Brian" using the provisioning API
    Then the OCS status code should be "401"
    And the HTTP status code should be "401"
    And user "Brian" should be disabled
