package com.realestate.portal;

import com.realestate.portal.servlet.PropertyServlet;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import jakarta.servlet.MultipartConfigElement;

@SpringBootApplication
@ServletComponentScan
public class RealEstatePortalApplication {

	public static void main(String[] args) {
		SpringApplication.run(RealEstatePortalApplication.class, args);
	}

	@Bean
	public ServletRegistrationBean<PropertyServlet> propertyServlet() {
		ServletRegistrationBean<PropertyServlet> bean =
				new ServletRegistrationBean<>(new com.realestate.portal.servlet.PropertyServlet(), "/properties");
		bean.setName("PropertyServlet");
		
		MultipartConfigElement multipartConfigElement = new MultipartConfigElement(
				"", 
				1024 * 1024 * 20,      // maxFileSize: 20MB
				1024 * 1024 * 100,     // maxRequestSize: 100MB
				1024 * 1024 * 2        // fileSizeThreshold: 2MB
		);
		bean.setMultipartConfig(multipartConfigElement);
		return bean;
	}

	@Bean
	public ServletRegistrationBean<com.realestate.portal.servlet.ReviewServlet> reviewServlet() {
		return new ServletRegistrationBean<>(new com.realestate.portal.servlet.ReviewServlet(), "/reviews");
	}

	@Bean
	public ServletRegistrationBean<com.realestate.portal.servlet.InquiryServlet> inquiryServlet() {
		return new ServletRegistrationBean<>(new com.realestate.portal.servlet.InquiryServlet(), "/inquiries");
	}

	@Bean
	public ServletRegistrationBean<com.realestate.portal.servlet.AdminServlet> adminServlet() {
		return new ServletRegistrationBean<>(new com.realestate.portal.servlet.AdminServlet(), "/admins");
	}

	@Bean
	public ServletRegistrationBean<com.realestate.portal.servlet.SellerServlet> sellerServlet() {
		return new ServletRegistrationBean<>(new com.realestate.portal.servlet.SellerServlet(), "/sellers");
	}
}