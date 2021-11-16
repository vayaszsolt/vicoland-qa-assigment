package com.vicoland;

import io.restassured.response.ResponseBody;

import java.util.*;

public class ResourceHolder {

    public static final ResourceHolder INSTANCE = ThreadLocal.withInitial(ResourceHolder::new).get();

    private final Map<String, String> resources = new HashMap<>();

    public void store(String key, String value) {
        resources.put(key, value);
    }

    public String get(String key) {
        String value = resources.get(key);

        if(Objects.isNull(value)) {
            throw new IllegalStateException(String.format("The %s resource is missing!", key));
        }

        return value;
    }

    public Collection<String> getAll() {
        return resources.values();
    }

    public void clear() {
        resources.clear();
    }
}
