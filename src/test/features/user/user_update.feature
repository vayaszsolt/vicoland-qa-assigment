Feature: User Update

  @CleanupResources
  Scenario: Update User
    Given I send a POST request to the resource identified by '/public/v1/users' url with body:
      | name   | Tenali Ramakrishna          |
      | gender | male                        |
      | email  | tenali.ramakrishna@101ce.com |
      | status | active                      |
    Then The request is completed with status code 201
    And I store the request resource in 'USER_RESOURCE' for future reference

    Given I send a PUT request to the resource identified by '%USER_RESOURCE%' url with body:
      | name   | Joe Biden           |
      | gender | female              |
      | email  | joe_biden@gmail.com |
      | status | inactive            |
    Then The request is completed with status code 200

    Given I send a GET request to the resource identified by '%USER_RESOURCE%' url
    Then The request is completed with status code 200
    And The response body contains the following information:
      | name   | Joe Biden           |
      | gender | female              |
      | email  | joe_biden@gmail.com |
      | status | inactive            |

  @CleanupResources
  Scenario: Updating User with duplicate email is not allowed
    Given I send a POST request to the resource identified by '/public/v1/users' url with body:
      | name   | Tenali Ramakrishna          |
      | gender | male                        |
      | email  | tenali.ramakrishna@101ce.com |
      | status | active                      |
    Then The request is completed with status code 201
    And I store the request resource in 'USER_RESOURCE_1' for future reference

    Given I send a POST request to the resource identified by '/public/v1/users' url with body:
      | name   | Joe Biden           |
      | gender | female              |
      | email  | joe_biden@gmail.com |
      | status | inactive            |
    Then The request is completed with status code 201
    And I store the request resource in 'USER_RESOURCE_2' for future reference

    Given I send a PUT request to the resource identified by '%USER_RESOURCE_1%' url with body:
      | email | joe_biden@gmail.com |
    Then The request is completed with status code 422
    And The response body contains the following information:
      | field[0]   | email                  |
      | message[0] | has already been taken |

  @CleanupResources
  Scenario: Updating User with duplicate name is allowed
    Given I send a POST request to the resource identified by '/public/v1/users' url with body:
      | name   | Tenali Ramakrishna          |
      | gender | male                        |
      | email  | tenali.ramakrishna@101ce.com |
      | status | active                      |
    Then The request is completed with status code 201
    And I store the request resource in 'USER_RESOURCE_1' for future reference

    Given I send a POST request to the resource identified by '/public/v1/users' url with body:
      | name   | Joe Biden           |
      | gender | female              |
      | email  | joe_biden@gmail.com |
      | status | inactive            |
    Then The request is completed with status code 201
    And I store the request resource in 'USER_RESOURCE_2' for future reference

    Given I send a PUT request to the resource identified by '%USER_RESOURCE_1%' url with body:
      | name | Joe Biden |
    Then The request is completed with status code 200
    And The response body contains the following information:
      | name   | Joe Biden                   |
      | gender | male                        |
      | email  | tenali.ramakrishna@101ce.com |
      | status | active                      |


  @CleanupResources
  Scenario: Updating User with invalid body data
    Given I send a POST request to the resource identified by '/public/v1/users' url with body:
      | name   | Tenali Ramakrishna          |
      | gender | male                        |
      | email  | tenali.ramakrishna@101ce.com |
      | status | active                      |
    Then The request is completed with status code 201
    And I store the request resource in 'USER_RESOURCE' for future reference

    Given I send a PUT request to the resource identified by '%USER_RESOURCE%' url with body:
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

  @CleanupResources
  Scenario: Updating User with empty body data
    Given I send a POST request to the resource identified by '/public/v1/users' url with body:
      | name   | Tenali Ramakrishna          |
      | gender | male                        |
      | email  | tenali.ramakrishna@101ce.com |
      | status | active                      |
    Then The request is completed with status code 201
    And I store the request resource in 'USER_RESOURCE' for future reference

    Given I send a PUT request to the resource identified by '%USER_RESOURCE%' url with body:
      | name   | "" |
      | gender | "" |
      | email  | "" |
      | status | "" |
    Given I send a GET request to the resource identified by '%USER_RESOURCE%' url
    Then The request is completed with status code 200
    And The response body contains the following information:
      | name   | Tenali Ramakrishna          |
      | gender | male                        |
      | email  | tenali.ramakrishna@101ce.com |
      | status | active                      |

    Given I send a PUT request to the resource identified by '%USER_RESOURCE%' url with body:
      | name   |  |
      | gender |  |
      | email  |  |
      | status |  |
    Given I send a GET request to the resource identified by '%USER_RESOURCE%' url
    Then The request is completed with status code 200
    And The response body contains the following information:
      | name   | Tenali Ramakrishna          |
      | gender | male                        |
      | email  | tenali.ramakrishna@101ce.com |
      | status | active                      |

  @CleanupResources
  Scenario: Update User with invalid body specification is allowed
    Given I send a POST request to the resource identified by '/public/v1/users' url with body:
      | name   | Tenali Ramakrishna          |
      | gender | male                        |
      | email  | tenali.ramakrishna@101ce.com |
      | status | active                      |
    Then The request is completed with status code 201
    And I store the request resource in 'USER_RESOURCE' for future reference

    Given I send a PUT request to the resource identified by '%USER_RESOURCE%' url with body:
      | name1 | Joe Biden |
    Then The request is completed with status code 200

    Given I send a PUT request to the resource identified by '%USER_RESOURCE%' url with body:
      | gender1 | female |
    Then The request is completed with status code 200

    Given I send a PUT request to the resource identified by '%USER_RESOURCE%' url with body:
      | email1 | joe_biden@gmail.com |
    Then The request is completed with status code 200

    Given I send a PUT request to the resource identified by '%USER_RESOURCE%' url with body:
      | status1 | inactive |
    Then The request is completed with status code 200

  @CleanupResources
  Scenario: Update User without performing any modification
    Given I send a POST request to the resource identified by '/public/v1/users' url with body:
      | name   | Tenali Ramakrishna          |
      | gender | male                        |
      | email  | tenali.ramakrishna@101ce.com |
      | status | active                      |
    Then The request is completed with status code 201
    And I store the request resource in 'USER_RESOURCE' for future reference

    Given I send a PUT request to the resource identified by '%USER_RESOURCE%' url with body:
      | name   | Tenali Ramakrishna          |
      | gender | male                        |
      | email  | tenali.ramakrishna@101ce.com |
      | status | active                      |
    Then The request is completed with status code 200

    Given I send a GET request to the resource identified by '%USER_RESOURCE%' url
    Then The request is completed with status code 200
    And The response body contains the following information:
      | name   | Tenali Ramakrishna          |
      | gender | male                        |
      | email  | tenali.ramakrishna@101ce.com |
      | status | active                      |

  Scenario: Update User who does not exist in the system
    Given I send a PUT request to the resource identified by '/public/v1/users/8923123214213' url with body:
      | name   | Tenali Ramakrishna          |
      | gender | male                        |
      | email  | tenali.ramakrishna@101ce.com |
      | status | active                      |
    Then The request is completed with status code 404

  @CleanupResources
  Scenario: Updating User without authentication token
    Given I send a POST request to the resource identified by '/public/v1/users' url with body:
      | name   | Tenali Ramakrishna          |
      | gender | male                        |
      | email  | tenali.ramakrishna@101ce.com |
      | status | active                      |
    Then The request is completed with status code 201
    And I store the request resource in 'USER_RESOURCE' for future reference
    Given I send a PUT request without authentication token to the resource identified by '%USER_RESOURCE%' url
    Then The request is completed with status code 401