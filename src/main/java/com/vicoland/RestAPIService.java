package com.vicoland;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import io.restassured.RestAssured;
import io.restassured.filter.log.LogDetail;
import io.restassured.http.Method;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

import java.util.Collections;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static org.hamcrest.Matchers.greaterThan;
import static org.hamcrest.Matchers.greaterThanOrEqualTo;

public class RestAPIService {

    private final Gson gson = new Gson();

    private final Pattern URL_RESOURCE_PATTERN = Pattern.compile("%(\\w+)%");

    public static final RestAPIService INSTANCE = new RestAPIService();

    public RestAPIService() {
        RestAssured.baseURI = ConfigService.INSTANCE.getApplicationBaseURL();
    }

    public Response sendWithEmptyBody(Method method, String url) {
        return send(method, url, Collections.emptyMap(), true, false);
    }

    public Response sendWithoutAuthentication(Method method, String url, Map<String, String> body) {
        return send(method, url, body, false, true);
    }

    public Response sendWithoutAuthentication(Method method, String url) {
        return send(method, url, Collections.emptyMap(), false, true);
    }

    public Response send(Method method, String url, Map<String, String> body) {
        return send(method, url, body, false, false);
    }

    public Response send(Method method, String url) {
        return send(method, url, Collections.emptyMap(), false, false);
    }

    private Response send(Method method, String url, Map<String, String> body, boolean requiredBodySpecification, boolean skipAuthenticationToken) {
        RequestSpecification request = RestAssured.given();

        if(!skipAuthenticationToken) {
            request.auth().oauth2(ConfigService.INSTANCE.getOAuthToken());
        }

        request.header("Content-Type", "application/json");

        if(!body.isEmpty() || requiredBodySpecification) {
            JsonObject requestParams = new JsonObject();
            body.forEach(requestParams::addProperty);
            request.body(gson.toJson(requestParams));
        }

        return request.request(method, buildUrl(url));
    }

    private String buildUrl(String url) {
        Matcher matcher = URL_RESOURCE_PATTERN.matcher(url);
        StringBuffer urlBuilder = new StringBuffer();

        while(matcher.find()) {
            String resourceKey = matcher.group(1);

            String resource = ResourceHolder.INSTANCE.get(resourceKey);

            matcher.appendReplacement(urlBuilder, resource);
        }
        matcher.appendTail(urlBuilder);

        return urlBuilder.toString();
    }
}
