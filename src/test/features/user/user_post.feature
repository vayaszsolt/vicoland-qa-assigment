Feature: Create Post for a certain User

  @CleanupResources
  Scenario: Create a Post for an User
    Given I send a POST request to the resource identified by '/public/v1/users' url with body:
      | name   | Tenali Ramakrishna           |
      | gender | male                         |
      | email  | tenali.ramakrishna@101ce.com |
      | status | active                       |
    Then The request is completed with status code 201
    And I store the request resource in 'USER_RESOURCE' for future reference

    Given I send a POST request to the resource identified by '%USER_RESOURCE%/posts' url with body:
      | title | How to make Hungarian Spice Ingredients               |
      | body  | adsadsa sa dsad sadsa dsad sadsa d asdsa dsaad sad as |
    Then The request is completed with status code 201
    And I store the request resource in 'USER_POST_RESOURCE' for future reference

    Given I send a POST request to the resource identified by '%USER_POST_RESOURCE%/comments' url with body:
      | body  | adsadsa sa dsad sadsa dsad sadsa d asdsa dsaad sad as |
      | name  | Tenali Ramakrishna                                    |
      | email | tenali.ramakrishna@101ce.com                          |
    Then The request is completed with status code 200
    And I store the request resource in 'USER_POST_COMMENT_RESOURCE' for future reference

    Given I send a GET request to the resource identified by '%USER_POST_RESOURCE%/comments' url
    Then The request is completed with status code 200
    And The response body contains the following information:
      | name  | Tenali Ramakrishna                                    |
      | email | tenali.ramakrishna@101ce.com                          |
      | body  | adsadsa sa dsad sadsa dsad sadsa d asdsa dsaad sad as |
