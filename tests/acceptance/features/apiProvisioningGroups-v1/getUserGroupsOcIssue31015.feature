@api @provisioning_api-app-required @skipOnLDAP
@skipOnOcV10 @notToImplementOnOCIS @issue-31015
Feature: get user groups
  As an admin
  I want to be able to get groups
  So that I can manage group membership

  Scenario: admin gets groups of an user, including groups containing a slash
    Given using OCS API version "1"
    And user "brand-new-user" has been created with default attributes and skeleton files
    And group "unused-group" has been created
    And group "brand-new-group" has been created
    And group "0" has been created
    And group "Admin & Finance (NP)" has been created
    And group "admin:Pokhara@Nepal" has been created
    And group "नेपाली" has been created
    And group "Mgmt/Sydney" has been created
    And group "var/../etc" has been created
    And group "priv/subadmins/1" has been created
    And user "brand-new-user" has been added to group "brand-new-group"
    And user "brand-new-user" has been added to group "0"
    And user "brand-new-user" has been added to group "Admin & Finance (NP)"
    And user "brand-new-user" has been added to group "admin:Pokhara@Nepal"
    And user "brand-new-user" has been added to group "नेपाली"
    And user "brand-new-user" has been added to group "Mgmt/Sydney"
    And user "brand-new-user" has been added to group "var/../etc"
    And user "brand-new-user" has been added to group "priv/subadmins/1"
    When the administrator gets all the groups of user "brand-new-user" using the provisioning API
    Then the groups returned by the API should be
      | brand-new-group      |
      | 0                    |
      | Admin & Finance (NP) |
      | admin:Pokhara@Nepal  |
      | नेपाली               |
      | Mgmt/Sydney          |
      | var/../etc           |
      | priv/subadmins/1     |
    And the OCS status code should be "100"
    And the HTTP status code should be "200"
