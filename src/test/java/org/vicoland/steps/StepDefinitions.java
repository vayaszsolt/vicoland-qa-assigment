package org.vicoland.steps;

import io.cucumber.java.DataTableType;
import io.cucumber.java.ParameterType;
import io.restassured.http.Method;

import java.util.Map;

public class StepDefinitions {

    @ParameterType(".*")
    public Method method(String methodName) {
        return Method.valueOf(methodName);
    }
}
