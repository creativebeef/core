@api @provisioning_api-app-required @skipOnLDAP
@skipOnOcV10 @notToImplementOnOCIS @issue-31015
Feature: add groups
  As an admin
  I want to be able to add groups
  So that I can more easily manage access to resources by groups rather than individual users

  Background:
    Given using OCS API version "2"

    # Note: these groups do get created OK, but:
    # 1) the "should exist" step fails because the API to check their existence does not work.
    # 2) the ordinary group deletion in AfterScenario does not work, because the
    #    that group-delete API does not work for groups with a slash in the name
  @issue-31015
  Scenario Outline: admin creates a group with a forward-slash in the group name
    When the administrator sends a group creation request for group "<group_id>" using the provisioning API
    Then the OCS status code should be "200"
    And the HTTP status code should be "200"
    And group "<group_id>" should exist
    Examples:
      | group_id         | comment                            |
      | Mgmt/Sydney      | Slash (special escaping happens)   |
      | Mgmt//NSW/Sydney | Multiple slash                     |
      | var/../etc       | using slash-dot-dot                |
      | priv/subadmins/1 | Subadmins mentioned not at the end |

	# A group name must not end in "/subadmins" because that would create ambiguity
	# with the endpoint for getting the subadmins of a group
  @issue-31015
  Scenario: admin tries to create a group with name ending in "/subadmins"
    Given group "brand-new-group" has been created
    When the administrator tries to send a group creation request for group "priv/subadmins" using the provisioning API
    Then the OCS status code should be "400"
    And the HTTP status code should be "400"
    And group "priv/subadmins" should not exist
