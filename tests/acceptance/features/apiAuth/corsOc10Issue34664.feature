@api @skipOnOcV10 @notToImplementOnOCIS
Feature: CORS headers correct expected behavior for issue 34664

  @issue-34664
  Scenario Outline: CORS headers should be returned when setting CORS domain sending Origin header
    Given user "Alice" has been created with default attributes and skeleton files
    And using OCS API version "<ocs_api_version>"
    And user "Alice" has added "https://aphno.badal" to the list of personal CORS domains
    When user "Alice" sends HTTP method "GET" to OCS API endpoint "<endpoint>" with headers
      | header | value               |
      | Origin | https://aphno.badal |
    Then the OCS status code should be "<ocs-code>"
    And the HTTP status code should be "<http-code>"
    Then the following headers should be set
      | header                        | value                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
      | Access-Control-Allow-Headers  | OC-Checksum,OC-Total-Length,OCS-APIREQUEST,X-OC-Mtime,Accept,Authorization,Brief,Content-Length,Content-Range,Content-Type,Date,Depth,Destination,Host,If,If-Match,If-Modified-Since,If-None-Match,If-Range,If-Unmodified-Since,Location,Lock-Token,Overwrite,Prefer,Range,Schedule-Reply,Timeout,User-Agent,X-Expected-Entity-Length,Accept-Language,Access-Control-Request-Method,Access-Control-Allow-Origin,ETag,OC-Autorename,OC-CalDav-Import,OC-Chunked,OC-Etag,OC-FileId,OC-LazyOps,OC-Total-File-Length,Origin,X-Request-ID,X-Requested-With |
      | Access-Control-Expose-Headers | Content-Location,DAV,ETag,Link,Lock-Token,OC-ETag,OC-Checksum,OC-FileId,OC-JobStatus-Location,Vary,Webdav-Location,X-Sabre-Status                                                                                                                                                                                                                                                                                                                                                                                                                     |
      | Access-Control-Allow-Origin   | https://aphno.badal                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
      | Access-Control-Allow-Methods  | GET,OPTIONS,POST,PUT,DELETE,MKCOL,PROPFIND,PATCH,PROPPATCH,REPORT                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
    Examples:
      | ocs_api_version | endpoint | ocs-code | http-code |
      | 1               | /config  | 100      | 200       |
      | 2               | /config  | 200      | 200       |
