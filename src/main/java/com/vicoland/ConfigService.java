package com.vicoland;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ConfigService {

    public static final ConfigService INSTANCE = new ConfigService();

    private final Properties configProperties;

    public ConfigService() {
        InputStream configFileStream = ConfigService.class.getResourceAsStream("/config.properties");

        configProperties = new Properties();
        try {
            configProperties.load(configFileStream);
        } catch (IOException e) {
            throw new IllegalStateException("The configuration.properties file cannot be loaded!");
        }
    }

    public String getApplicationBaseURL() {
        return configProperties.getProperty("app_base_url");
    }

    public String getOAuthToken() {
        return configProperties.getProperty("oauth_token");
    }
}
