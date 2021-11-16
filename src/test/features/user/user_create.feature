Feature: User Creation

  @CleanupResources
  Scenario: Create User
    Given I send a POST request to the resource identified by '/public/v1/users' url with body:
      | name   | Tenali Ramakrishna          |
      | gender | male                        |
      | email  | tenali.ramakrishna@101ce.com |
      | status | active                      |
    Then The request is completed with status code 201
    And I store the request resource in 'USER_RESOURCE' for future reference

    Given I send a GET request to the resource identified by '%USER_RESOURCE%' url
    When The request is completed with status code 200
    And The response body contains the following information:
      | name   | Tenali Ramakrishna          |
      | gender | male                        |
      | email  | tenali.ramakrishna@101ce.com |
      | status | active                      |

    Given I send a GET request without authentication token to the resource identified by '%USER_RESOURCE%' url
    When The request is completed with status code 200
    And The response body contains the following information:
      | name   | Tenali Ramakrishna          |
      | gender | male                        |
      | email  | tenali.ramakrishna@101ce.com |
      | status | active                      |

  @CleanupResources
  Scenario: Create User and retrieve it without authentication token
    Given I send a POST request to the resource identified by '/public/v1/users' url with body:
      | name   | Tenali Ramakrishna          |
      | gender | male                        |
      | email  | tenali.ramakrishna@101ce.com |
      | status | active                      |
    Then The request is completed with status code 201
    And I store the request resource in 'USER_RESOURCE' for future reference

    Given I send a GET request without authentication token to the resource identified by '%USER_RESOURCE%' url
    When The request is completed with status code 200
    And The response body contains the following information:
      | name   | Tenali Ramakrishna          |
      | gender | male                        |
      | email  | tenali.ramakrishna@101ce.com |
      | status | active                      |

  Scenario: Create User with invalid body data
    Given I send a POST request to the resource identified by '/public/v1/users' url with body:
      | name   | Tenali Ramakrishna |
      | gender | male123            |
      | email  | tenali.ramakrishna |
      | status | active12           |
    Then The request is completed with status code 422
    And The response body contains the following information:
      | field[0]   | gender         |
      | message[0] | can't be blank |
      | field[1]   | status         |
      | message[1] | can't be blank |
      | field[2]   | email          |
      | message[2] | is invalid     |

    Given I send a POST request to the resource identified by '/public/v1/users' url with body:
      | name   |  |
      | gender |  |
      | email  |  |
      | status |  |
    Then The request is completed with status code 422
    And The response body contains the following information:
      | field[2]   | gender         |
      | message[2] | can't be blank |
      | field[3]   | status         |
      | message[3] | can't be blank |
      | field[0]   | email          |
      | message[0] | can't be blank |
      | field[1]   | name           |
      | message[1] | can't be blank |

  Scenario: Create User with invalid body specification
    Given I send a POST request to the resource identified by '/public/v1/users' url with body:
      | name1  | Tenali Ramakrishna          |
      | gender | male                        |
      | email  | tenali.ramakrishna@15ce.com |
      | status | active                      |
    Then The request is completed with status code 422
    Given I send a POST request to the resource identified by '/public/v1/users' url with body:
      | name    | Tenali Ramakrishna          |
      | gender2 | male                        |
      | email   | tenali.ramakrishna@15ce.com |
      | status  | active                      |
    Then The request is completed with status code 422
    Given I send a POST request to the resource identified by '/public/v1/users' url with body:
      | name   | Tenali Ramakrishna          |
      | gender | male                        |
      | email3 | tenali.ramakrishna@15ce.com |
      | status | active                      |
    Then The request is completed with status code 422
    Given I send a POST request to the resource identified by '/public/v1/users' url with body:
      | name    | Tenali Ramakrishna          |
      | gender  | male                        |
      | email   | tenali.ramakrishna@15ce.com |
      | status4 | active                      |
    Then The request is completed with status code 422
    Given I send a POST request to the resource identified by '/public/v1/users' url with empty body
    Then The request is completed with status code 422

  Scenario: Creating User without authentication token
    Given I send a POST request without authentication token to the resource identified by '/public/v1/users' url with body:
      | name   | Tenali Ramakrishna          |
      | gender | male                        |
      | email  | tenali.ramakrishna@101ce.com |
      | status | active                      |
    Then The request is completed with status code 401

