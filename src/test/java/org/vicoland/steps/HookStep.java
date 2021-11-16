package org.vicoland.steps;

import com.vicoland.ResourceHolder;
import com.vicoland.RestAPIService;
import io.cucumber.java.After;
import io.cucumber.java.BeforeAll;
import io.restassured.http.Method;
import io.restassured.response.Response;
import org.apache.http.HttpStatus;
import org.apache.logging.log4j.Level;
import org.apache.logging.log4j.core.appender.ConsoleAppender;
import org.apache.logging.log4j.core.config.Configurator;
import org.apache.logging.log4j.core.config.builder.api.AppenderComponentBuilder;
import org.apache.logging.log4j.core.config.builder.api.ConfigurationBuilder;
import org.apache.logging.log4j.core.config.builder.api.ConfigurationBuilderFactory;
import org.apache.logging.log4j.core.config.builder.api.RootLoggerComponentBuilder;
import org.apache.logging.log4j.core.config.builder.impl.BuiltConfiguration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class HookStep {

    private static final Logger LOG = LoggerFactory.getLogger(HookStep.class);

    @BeforeAll
    public static void init() {
        ConfigurationBuilder<BuiltConfiguration> builder = ConfigurationBuilderFactory.newConfigurationBuilder();

        builder.setStatusLevel(Level.DEBUG);
        builder.setConfigurationName("DefaultLogger");

        // create a console appender
        String pattern = "%d %p %c [%t] %m%n";
        AppenderComponentBuilder appenderBuilder = builder.newAppender("Console", "CONSOLE").addAttribute("target",
                ConsoleAppender.Target.SYSTEM_OUT);
        appenderBuilder.add(builder.newLayout("PatternLayout")
                .addAttribute("pattern", pattern));

        builder.add(appenderBuilder);

        Configurator.initialize(builder.build());
    }

    @After("@CleanupResources")
    public void cleanupResources() {
        ResourceHolder.INSTANCE.getAll().forEach(resource -> {
            Response response = RestAPIService.INSTANCE.send(Method.DELETE, resource);

            if (response.getStatusCode() != HttpStatus.SC_NO_CONTENT) {
                LOG.error("The {} resource couldn't clean up.", resource);
            }
        });

        ResourceHolder.INSTANCE.clear();
    }
}
