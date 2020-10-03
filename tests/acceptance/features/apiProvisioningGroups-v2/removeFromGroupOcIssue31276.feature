@api @provisioning_api-app-required @skipOnLDAP
@skipOnOcV10 @notToImplementOnOCIS @issue-31276
Feature: remove a user from a group
  As an admin
  I want to be able to remove a user from a group
  So that I can manage user access to group resources

  @issue-31276
  Scenario: normal user tries to remove a user in their group
    Given using OCS API version "2"
    And these users have been created with default attributes and skeleton files:
      | username         |
      | brand-new-user   |
      | another-new-user |
    And group "brand-new-group" has been created
    And user "brand-new-user" has been added to group "brand-new-group"
    And user "another-new-user" has been added to group "brand-new-group"
    When user "brand-new-user" tries to remove user "another-new-user" from group "brand-new-group" using the provisioning API
    Then the OCS status code should be "401"
    And the HTTP status code should be "401"
    And user "another-new-user" should belong to group "brand-new-group"
