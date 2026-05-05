package com.realestate.portal;

import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.boot.web.servlet.server.ConfigurableServletWebServerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import java.io.File;

@Configuration
public class WebConfig {

    @Bean
    public WebServerFactoryCustomizer<ConfigurableServletWebServerFactory> webServerFactoryCustomizer() {
        return factory -> {
            File[] possiblePaths = {
                new File("src/main/webapp"),
                new File("portal/src/main/webapp"),
                new File("real-estate-portal/portal/src/main/webapp")
            };
            for (File path : possiblePaths) {
                if (path.exists() && path.isDirectory()) {
                    factory.setDocumentRoot(path);
                    return;
                }
            }
            // Fallback
            factory.setDocumentRoot(new File("real-estate-portal/portal/src/main/webapp"));
        };
    }
}