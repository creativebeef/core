@api @provisioning_api-app-required @skipOnLDAP
@skipOnOcV10 @notToImplementOnOCIS @issue-31276
Feature: delete groups
  As an admin
  I want to be able to delete groups
  So that I can remove unnecessary groups

  Background:
    Given using OCS API version "2"

  Scenario: normal user tries to delete the group
    And user "brand-new-user" has been created with default attributes and skeleton files
    And group "brand-new-group" has been created
    And user "brand-new-user" has been added to group "brand-new-group"
    When user "brand-new-user" tries to delete group "brand-new-group" using the provisioning API
    Then the OCS status code should be "401"
    And the HTTP status code should be "401"
    And group "brand-new-group" should exist

  Scenario: subadmin of the group tries to delete the group
    And user "subadmin" has been created with default attributes and skeleton files
    And group "brand-new-group" has been created
    And user "subadmin" has been made a subadmin of group "brand-new-group"
    When user "subadmin" tries to delete group "brand-new-group" using the provisioning API
    Then the OCS status code should be "401"
    And the HTTP status code should be "401"
    And group "brand-new-group" should exist
