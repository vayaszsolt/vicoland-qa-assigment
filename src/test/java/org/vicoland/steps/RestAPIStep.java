package org.vicoland.steps;

import com.vicoland.ResourceHolder;
import com.vicoland.ResponseHolder;
import com.vicoland.RestAPIService;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.restassured.http.Method;
import io.restassured.response.Response;

public class RestAPIStep {

    @Given("I send a {method} request without authentication token to the resource identified by {string} url with body:")
    public void sendRestAPIRequestWithoutAuthenticationToken(Method method, String url, DataTable dataTable) {
        Response response = RestAPIService.INSTANCE.sendWithoutAuthentication(method, url, dataTable.asMap());
        ResponseHolder.INSTANCE.store(response);
    }

    @Given("I send a {method} request to the resource identified by {string} url with body:")
    public void sendRestAPIRequest(Method method, String url, DataTable dataTable) {
        Response response = RestAPIService.INSTANCE.send(method, url, dataTable.asMap());
        ResponseHolder.INSTANCE.store(response);
    }

    @Given("I send a {method} request to the resource identified by {string} url with empty body")
    public void sendRestAPIRequestWithEmptyBody(Method method, String url) {
        Response response = RestAPIService.INSTANCE.sendWithEmptyBody(method, url);
        ResponseHolder.INSTANCE.store(response);
    }

    @Given("I send a {method} request to the resource identified by {string} url")
    public void sendRestAPIRequest(Method method, String url) {
        Response response = RestAPIService.INSTANCE.send(method, url);
        ResponseHolder.INSTANCE.store(response);
    }

    @Given("I send a {method} request without authentication token to the resource identified by {string} url")
    public void sendRestAPIRequestWithoutAuthenticationToken(Method method, String url) {
        Response response = RestAPIService.INSTANCE.sendWithoutAuthentication(method, url);
        ResponseHolder.INSTANCE.store(response);
    }

    @And("I store the request resource in {string} for future reference")
    public void storeResourceFromResponse(String resourceKey) {
        Response response = ResponseHolder.INSTANCE.get();

        ResourceHolder.INSTANCE.store(resourceKey, response.getHeader("Location"));
    }
}
