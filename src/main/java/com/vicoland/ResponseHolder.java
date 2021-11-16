package com.vicoland;

import io.restassured.response.Response;

import java.util.Objects;

public class ResponseHolder {

    public static final ResponseHolder INSTANCE = ThreadLocal.withInitial(ResponseHolder::new).get();

    private Response response;

    public void store(Response response) {
        this.response = response;
    }

    public Response get() {
        if(Objects.isNull(response)) {
            throw new IllegalStateException("The response is empty! Perform a request and store it. Only after you can use the holder to access the request's response!");
        }

        return  response;
    }
}
