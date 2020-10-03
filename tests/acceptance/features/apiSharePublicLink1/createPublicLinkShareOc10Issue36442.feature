@api @files_sharing-app-required @public_link_share-feature-required @skipOnOcis-EOS-Storage @issue-ocis-reva-315 @issue-ocis-reva-316
@skipOnOcV10 @notToImplementOnOCIS @issue-36442

Feature: create a public link share

  Background:
    Given user "Alice" has been created with default attributes and skeleton files

  @issue-36442 @issue-ocis-reva-41
  Scenario Outline: Creating a public link share with read+create permissions defaults to read permissions when public upload disabled globally
    Given using OCS API version "<ocs_api_version>"
    And parameter "shareapi_allow_public_upload" of app "core" has been set to "no"
    And user "Alice" has created folder "/afolder"
    When user "Alice" creates a public link share using the sharing API with settings
      | path        | /afolder    |
      | permissions | read,create |
     Then the fields of the last response to user "Alice" should include
      | id          | A_STRING    |
      | share_type  | public_link |
      | permissions | read        |
    And the OCS status code should be "<ocs_status_code>"
    And the HTTP status code should be "<http_status_code>"
     And the public upload to the last publicly shared folder using the old public WebDAV API should fail with HTTP status code "403"
     And the public upload to the last publicly shared folder using the new public WebDAV API should fail with HTTP status code "403"
    Examples:
      | ocs_api_version | ocs_status_code | http_status_code |
      | 1               | 100             | 200              |
      | 2               | 200             | 200              |

  @issue-36442 @issue-ocis-reva-41
  Scenario Outline: Creating a public link share with create permissions defaults to read permissions when public upload disabled globally
    Given using OCS API version "<ocs_api_version>"
    And parameter "shareapi_allow_public_upload" of app "core" has been set to "no"
    And user "Alice" has created folder "/afolder"
    When user "Alice" creates a public link share using the sharing API with settings
      | path        | /afolder |
      | permissions | create   |
     Then the fields of the last response to user "Alice" should include
      | id          | A_STRING    |
      | share_type  | public_link |
      | permissions | read        |
    Then the OCS status code should be "<ocs_status_code>"
    And the HTTP status code should be "<http_status_code>"
     And the public upload to the last publicly shared folder using the old public WebDAV API should fail with HTTP status code "403"
     And the public upload to the last publicly shared folder using the new public WebDAV API should fail with HTTP status code "403"
    Examples:
      | ocs_api_version | ocs_status_code | http_status_code |
      | 1               | 100             | 200              |
      | 2               | 200             | 200              |

  @issue-36442 @issue-ocis-reva-41
  Scenario Outline: Creating a public link share with read+create permissions defaults to read permissions when public upload disabled globally
    Given using OCS API version "<ocs_api_version>"
    And user "Alice" has created folder "/afolder"
    And user "Alice" has created a public link share with settings
      | path        | /afolder |
      | permissions | read     |
    And parameter "shareapi_allow_public_upload" of app "core" has been set to "no"
    When user "Alice" tries to update the last share using the sharing API with
      | permissions | read,create |
    Then the fields of the last response to user "Alice" should include
      | id          | A_STRING    |
      | share_type  | public_link |
      | permissions | read        |
    Then the OCS status code should be "<ocs_status_code>"
    And the HTTP status code should be "<http_status_code>"
     And the public upload to the last publicly shared folder using the old public WebDAV API should fail with HTTP status code "403"
     And the public upload to the last publicly shared folder using the new public WebDAV API should fail with HTTP status code "403"
    Examples:
      | ocs_api_version | ocs_status_code | http_status_code |
      | 1               | 100             | 200              |
      | 2               | 200             | 200              |

  @issue-36442 @issue-ocis-reva-41
  Scenario Outline: Creating a public link share with read+create permissions defaults to read permissions when public upload disabled globally
    Given using OCS API version "<ocs_api_version>"
    And user "Alice" has created folder "/afolder"
    And user "Alice" has created a public link share with settings
      | path        | /afolder |
      | permissions | read     |
    And parameter "shareapi_allow_public_upload" of app "core" has been set to "no"
    When user "Alice" tries to update the last share using the sharing API with
      | permissions | <permission> |
    Then the fields of the last response to user "Alice" should include
      | id          | A_STRING    |
      | share_type  | public_link |
      | permissions | read        |
    Then the OCS status code should be "<ocs_status_code>"
    And the HTTP status code should be "<http_status_code>"
     And the public upload to the last publicly shared folder using the old public WebDAV API should fail with HTTP status code "403"
     And the public upload to the last publicly shared folder using the new public WebDAV API should fail with HTTP status code "403"
    Examples:
      | ocs_api_version | ocs_status_code | http_status_code | permission                |
      | 1               | 100             | 200              | create                     |
      | 2               | 200             | 200              | create                     |
      | 1               | 100             | 200              | create,read,update         |
      | 2               | 200             | 200              | create,read,update         |
      | 1               | 100             | 200              | read,create,update,delete  |
      | 2               | 200             | 200              | read,create,update,delete  |
