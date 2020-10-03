@api @provisioning_api-app-required @skipOnLDAP
@skipOnOcV10 @notToImplementOnOCIS @issue-31276
Feature: add users to group
  As a admin
  I want to be able to add users to a group
  So that I can give a user access to the resources of the group

  Scenario: normal user tries to add himself to a group
    Given using OCS API version "2"
    And user "brand-new-user" has been created with default attributes and skeleton files
    When user "brand-new-user" tries to add himself to group "brand-new-group" using the provisioning API
    Then the OCS status code should be "401"
    And the HTTP status code should be "401"
    And the API should not return any data
