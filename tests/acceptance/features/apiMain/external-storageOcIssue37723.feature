@api @local_storage @skipOnOcV10 @notToImplementOnOCIS
Feature: external-storage

  @issue-37723
  Scenario: Download a file that exists in filecache but not storage fails with 404
    Given using OCS API version "1"
    And using old DAV path
    And user "Alice" has been created with default attributes and skeleton files
    And user "Alice" has created folder "/local_storage/foo3"
    And user "Alice" has moved file "/textfile0.txt" to "/local_storage/foo3/textfile0.txt"
    And file "foo3/textfile0.txt" has been deleted from local storage on the server
    When user "Alice" downloads file "local_storage/foo3/textfile0.txt" using the WebDAV API
    Then the HTTP status code should be "404"
    And as "Alice" file "local_storage/foo3/textfile0.txt" should not exist
