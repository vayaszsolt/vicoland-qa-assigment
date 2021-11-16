# vicoland-qa-assigment

The project contains the code assigment implementation.

The project didn't contain only the scenarios from the code assigment description.
I chose to cover all of the possible flows for testing the User basic operation endpoints (create/update/delete).

The user's post creation and assign a comment to the post it is the flow from the code assigment description.

## Test Use Cases

The test's use cases are defined in a Gherkin language using Cucumber.
These use cases are located inside the 'src/test/features' folder.

## Running the tests

The tests can be run from an Idea (eg. IntelJIdea) or using Maven.

1. Using IDEA there are two option:
   1. The src/test/java/org/vicoland/test/AllTest.java is the runner who triggers the all the tests. 
   2. There are separate test runners by feature: 
      1. src/test/java/org/vicoland/test/user/UserCreateTest.java
      2. src/test/java/org/vicoland/test/user/UserDeleteTest.java
      3. src/test/java/org/vicoland/test/user/UserDeleteTest.java
      4. src/test/java/org/vicoland/test/user/UserPostTest.java
2. Using Maven: It is required the call the integration-test maven phase. This phase is used by the failsafe maven plugin in order to execute the AllTest.java runner. 