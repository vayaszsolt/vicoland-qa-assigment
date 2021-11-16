Feature: User Deletion

  @CleanupResources
  Scenario: Delete User
    Given I send a POST request to the resource identified by '/public/v1/users' url with body:
      | name   | Tenali Ramakrishna           |
      | gender | male                         |
      | email  | tenali.ramakrishna@101ce.com |
      | status | active                       |
    Then The request is completed with status code 201
    And I store the request resource in 'USER_RESOURCE' for future reference

    Given I send a DELETE request to the resource identified by '%USER_RESOURCE%' url
    Then The request is completed with status code 204

    Given I send a GET request to the resource identified by '%USER_RESOURCE%' url
    Then The request is completed with status code 404

  Scenario: Delete User who does not exist in the system
    Given I send a DELETE request to the resource identified by '/public/v1/users/8923123214213' url
    Then The request is completed with status code 404

  @CleanupResources
  Scenario: Delete User without authentication token
    Given I send a POST request to the resource identified by '/public/v1/users' url with body:
      | name   | Tenali Ramakrishna           |
      | gender | male                         |
      | email  | tenali.ramakrishna@101ce.com |
      | status | active                       |
    Then The request is completed with status code 201
    And I store the request resource in 'USER_RESOURCE' for future reference

    Given I send a DELETE request without authentication token to the resource identified by '%USER_RESOURCE%' url
    Then The request is completed with status code 401