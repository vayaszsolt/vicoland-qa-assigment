package org.vicoland.steps;

import com.vicoland.ResponseHolder;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.restassured.response.Response;

import java.util.List;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.hasItems;
import static org.junit.Assert.assertEquals;

public class RestAPIAssertionStep {

    private static final String RESPONSE_GET_PREFIX_PATH = "data.";

    private static final String ERROR_MESSAGE_RESPONSE_BODY_PROPERTY_MISSING_OR_MISMATCH_VALUE = "The response body %s not contains the expected property or the value of the property not match";

    @Then("The request is completed with status code {int}")
    public void theRequestIsCompletedWithStatusCode(int statusCode) {
        Response response = ResponseHolder.INSTANCE.get();

        assertEquals("Body: " + response.asPrettyString(), statusCode, response.getStatusCode());
    }

    @And("The response body contains the following information:")
    public void theResponseBodyContainsTheFollowingInformation(DataTable dataTable) {
        Response response = ResponseHolder.INSTANCE.get();

        Map<String, String> expectedProperties = dataTable.asMap();

        expectedProperties.forEach((key, expectedValue) -> {
            Object actualValue = response.getBody().path(RESPONSE_GET_PREFIX_PATH + key);
            String errorMessage = String.format(ERROR_MESSAGE_RESPONSE_BODY_PROPERTY_MISSING_OR_MISMATCH_VALUE, response.getBody().asPrettyString());

            if(actualValue instanceof List) {
                List<String> actualValueList = ((List) actualValue);

                assertThat(errorMessage, actualValueList, hasItems(expectedValue));
            } else {
                assertEquals(errorMessage, expectedValue, actualValue);
            }
        });
    }
}
