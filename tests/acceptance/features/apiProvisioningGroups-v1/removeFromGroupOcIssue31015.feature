@api @provisioning_api-app-required @skipOnLDAP
@skipOnOcV10 @notToImplementOnOCIS @issue-31015
Feature: remove a user from a group
  As an admin
  I want to be able to remove a user from a group
  So that I can manage user access to group resources

  Scenario Outline: admin removes a user from a group that has a forward-slash in the group name
    Given using OCS API version "1"
    And user "brand-new-user" has been created with default attributes and skeleton files
    And group "<group_id>" has been created
    And user "brand-new-user" has been added to group "<group_id>"
    When the administrator removes user "brand-new-user" from group "<group_id>" using the provisioning API
    Then the OCS status code should be "100"
    And the HTTP status code should be "200"
    And user "brand-new-user" should not belong to group "<group_id>"
    Examples:
      | group_id         | comment                            |
      | Mgmt/Sydney      | Slash (special escaping happens)   |
      | Mgmt//NSW/Sydney | Multiple slash                     |
      | var/../etc       | using slash-dot-dot                |
      | priv/subadmins/1 | Subadmins mentioned not at the end |
