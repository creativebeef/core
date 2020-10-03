@api @provisioning_api-app-required @skipOnLDAP
@skipOnOcV10 @notToImplementOnOCIS @issue-31015
Feature: delete groups
  As an admin
  I want to be able to delete groups
  So that I can remove unnecessary groups

  @issue-31015
  Scenario Outline: admin deletes a group that has a forward-slash in the group name
    Given using OCS API version "2"
    And group "<group_id>" has been created
    When the administrator deletes group "<group_id>" using the provisioning API
    Then the OCS status code should be "200"
    And the HTTP status code should be "200"
    And group "<group_id>" should not exist
    Examples:
      | group_id         | comment                            |
      | Mgmt/Sydney      | Slash (special escaping happens)   |
      | Mgmt//NSW/Sydney | Multiple slash                     |
      | var/../etc       | using slash-dot-dot                |
      | priv/subadmins/1 | Subadmins mentioned not at the end |
