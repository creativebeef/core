@api @federation-app-required @files_sharing-app-required @skipOnOcV10 @notToImplementOnOCIS
Feature: federated

  Background:
    Given using server "REMOTE"
    And user "Alice" has been created with default attributes and skeleton files
    And using server "LOCAL"
    And user "Brian" has been created with default attributes and skeleton files

  @issue-31276
  Scenario Outline: Remote sharee tries to delete an accepted federated share sending wrong password
    Given user "Alice" from server "REMOTE" has shared "/textfile0.txt" with user "Brian" from server "LOCAL"
    And user "Brian" from server "LOCAL" has accepted the last pending share
    And using OCS API version "<ocs-api-version>"
    When user "Brian" deletes the last federated cloud share with password "invalid" using the sharing API
    Then the OCS status code should be "401"
    And the HTTP status code should be "401"
    And user "Brian" should see the following elements
      | /textfile0%20(2).txt |
    When user "Brian" gets the list of federated cloud shares using the sharing API
    Then the fields of the last response about user "Alice" sharing with user "Brian" should include
      | id          | A_STRING                 |
      | remote      | REMOTE                   |
      | remote_id   | A_STRING                 |
      | share_token | A_TOKEN                  |
      | name        | /textfile0.txt           |
      | owner       | %username%               |
      | user        | %username%               |
      | mountpoint  | /textfile0 (2).txt       |
      | accepted    | 1                        |
      | type        | file                     |
      | permissions | share,delete,update,read |
    When user "Brian" gets the list of pending federated cloud shares using the sharing API
    Then the response should contain 0 entries
    Examples:
      | ocs-api-version |
      | 1               |
      | 2               |

  @issue-31276
  Scenario Outline: Remote sharee tries to delete a pending federated share sending wrong password
    Given user "Alice" from server "REMOTE" has shared "/textfile0.txt" with user "Brian" from server "LOCAL"
    And using OCS API version "<ocs-api-version>"
    When user "Brian" deletes the last pending federated cloud share with password "invalid" using the sharing API
    Then the OCS status code should be "401"
    And the HTTP status code should be "401"
    And user "Brian" should not see the following elements
      | /textfile0%20(2).txt |
    When user "Brian" gets the list of pending federated cloud shares using the sharing API
    Then the fields of the last response about user "Alice" sharing with user "Brian" should include
      | id          | A_STRING                                   |
      | remote      | REMOTE                                     |
      | remote_id   | A_STRING                                   |
      | share_token | A_TOKEN                                    |
      | name        | /textfile0.txt                             |
      | owner       | %username%                                 |
      | user        | %username%                                 |
      | mountpoint  | {{TemporaryMountPointName#/textfile0.txt}} |
      | accepted    | 0                                          |
    When user "Brian" gets the list of federated cloud shares using the sharing API
    Then the response should contain 0 entries
    Examples:
      | ocs-api-version |
      | 1               |
      | 2               |

  @issue-35154
  Scenario: receive a local share that has the same name as a previously received remote share
    Given using server "REMOTE"
    And user "Alice" has created folder "/zzzfolder"
    And user "Alice" has created folder "zzzfolder/remote"
    And user "Alice" has uploaded file with content "remote content" to "/randomfile.txt"
    And using server "LOCAL"
    And user "Carol" has been created with default attributes and skeleton files
    And user "Brian" has created folder "/zzzfolder"
    And user "Brian" has created folder "zzzfolder/local"
    And user "Brian" has uploaded file with content "local content" to "/randomfile.txt"
    When user "Alice" from server "REMOTE" shares "zzzfolder" with user "Carol" from server "LOCAL" using the sharing API
    And user "Carol" from server "LOCAL" accepts the last pending share using the sharing API
    And user "Alice" from server "REMOTE" shares "randomfile.txt" with user "Carol" from server "LOCAL" using the sharing API
    And user "Carol" from server "LOCAL" accepts the last pending share using the sharing API
    And user "Brian" shares folder "zzzfolder" with user "Carol" using the sharing API
    And user "Brian" shares folder "randomfile.txt" with user "Carol" using the sharing API
    # local shares are taking priority at the moment
    Then as "Carol" folder "zzzfolder (2)/remote" should exist
    And as "Carol" folder "zzzfolder/local" should exist
    And the content of file "/randomfile (2).txt" for user "Carol" on server "LOCAL" should be "remote content"
    And the content of file "/randomfile.txt" for user "Carol" on server "LOCAL" should be "local content"
