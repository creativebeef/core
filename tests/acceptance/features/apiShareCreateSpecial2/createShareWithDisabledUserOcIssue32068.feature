@api @files_sharing-app-required @issue-ocis-reva-243
@skipOnOcV10 @notToImplementOnOCIS @issue-32068
Feature: share resources with a disabled user

  @issue-32068
  Scenario: Creating a new share with a disabled user
    Given user "Alice" has been created with default attributes and skeleton files
    And using OCS API version "2"
    And user "Brian" has been created with default attributes and without skeleton files
    And user "Alice" has been disabled
    When user "Alice" shares file "welcome.txt" with user "Brian" using the sharing API
    Then the OCS status code should be "401"
    And the HTTP status code should be "401"
