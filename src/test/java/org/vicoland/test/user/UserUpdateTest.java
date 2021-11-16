package org.vicoland.test.user;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(
        features = {"src/test/features/user/user_update.feature"},
        glue = {"org.vicoland.steps"},
        plugin = {"pretty"})
public class UserUpdateTest {
}
