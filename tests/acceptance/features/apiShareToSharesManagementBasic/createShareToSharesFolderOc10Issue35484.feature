@api @files_sharing-app-required
@notToImplementOnOCIS @skipOnOcV10 @issue-35484
Feature: sharing

  @issue-35484
  @skipOnOcis-OC-Storage @issue-ocis-reva-11
  Scenario: share with user when username contains capital letters
    Given the administrator has set the default folder for received shares to "Shares"
    And auto-accept shares has been disabled
    And user "Alice" has been created with default attributes and without skeleton files
    And user "Alice" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    And these users have been created without skeleton files:
      | username |
      | brian    |
    And user "Alice" has uploaded file with content "Random data" to "/randomfile.txt"
    When user "Alice" shares file "/randomfile.txt" with user "BRIAN" using the sharing API
    Then the OCS status code should be "100"
    And the HTTP status code should be "200"
    And the fields of the last response to user "Alice" sharing with user "BRIAN" should include
      | share_with  | %username%             |
      | file_target | /Shares/randomfile.txt |
      | path        | /randomfile.txt        |
      | permissions | share,read,update      |
      | uid_owner   | %username%             |
    # Because of issue-35484 the share is not seen to be pending, so it cannot
    # even be accepted, and so the file does not exist for Brian
    #
    #When user "brian" accepts share "/randomfile.txt" offered by user "Alice" using the sharing API
    #Then user "brian" should see the following elements
    #  | /Shares/randomfile.txt |
    #And the content of file "randomfile.txt" for user "brian" should be "Random data"
    Then user "brian" should not see the following elements if the upper and lower case username are different
      | /Shares/randomfile.txt |
