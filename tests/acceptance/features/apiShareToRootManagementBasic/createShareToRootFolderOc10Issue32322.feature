@api @files_sharing-app-required
@notToImplementOnOCIS @skipOnOcV10 @issue-32322
Feature: sharing

  Background:
    Given user "Alice" has been created with default attributes and without skeleton files

  @smokeTest
  @skipOnEncryptionType:user-keys @issue-32322
  Scenario Outline: Creating a share of a file with a user, the default permissions are read(1)+update(2)+can-share(16)
    Given user "Alice" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    And using OCS API version "<ocs_api_version>"
    And user "Brian" has been created with default attributes and without skeleton files
    When user "Alice" shares file "textfile0.txt" with user "Brian" using the sharing API
    Then the OCS status code should be "<ocs_status_code>"
    And the HTTP status code should be "200"
    And the fields of the last response to user "Alice" sharing with user "Brian" should include
      | share_with             | %username%         |
      | share_with_displayname | %displayname%      |
      | file_target            | /textfile0 (2).txt |
      | path                   | /textfile0.txt     |
      | permissions            | share,read,update  |
      | uid_owner              | %username%         |
      | displayname_owner      | %displayname%      |
      | item_type              | file               |
      | mimetype               | text/plain         |
      | storage_id             | ANY_VALUE          |
      | share_type             | user               |
    And the content of file "/textfile0 (2).txt" for user "Brian" should be "ownCloud test text file 0"
    Examples:
      | ocs_api_version | ocs_status_code |
      | 1               | 100             |
      | 2               | 200             |

  @smokeTest
  @skipOnEncryptionType:user-keys @issue-32322
  Scenario Outline: Creating a share of a file containing commas in the filename, with a user, the default permissions are read(1)+update(2)+can-share(16)
    Given using OCS API version "<ocs_api_version>"
    And user "Brian" has been created with default attributes and without skeleton files
    And user "Alice" has uploaded file with content "file with comma in filename" to "/sample,1.txt"
    When user "Alice" shares file "sample,1.txt" with user "Brian" using the sharing API
    Then the OCS status code should be "<ocs_status_code>"
    And the HTTP status code should be "200"
    And the fields of the last response to user "Alice" sharing with user "Brian" should include
      | share_with             | %username%        |
      | share_with_displayname | %displayname%     |
      | file_target            | /sample,1 (2).txt |
      | path                   | /sample,1.txt     |
      | permissions            | share,read,update |
      | uid_owner              | %username%        |
      | displayname_owner      | %displayname%     |
      | item_type              | file              |
      | mimetype               | text/plain        |
      | storage_id             | ANY_VALUE         |
      | share_type             | user              |
    And the content of file "/sample,1 (2).txt" for user "Brian" should be "file with comma in filename"
    Examples:
      | ocs_api_version | ocs_status_code |
      | 1               | 100             |
      | 2               | 200             |

