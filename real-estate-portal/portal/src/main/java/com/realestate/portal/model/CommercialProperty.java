package com.realestate.portal.model;

// Inheritance
public class CommercialProperty extends Property {

    // Information hiding
    private String businessType;

    // Constructor
    public CommercialProperty() {
        super();
    }

    // Encapsulation
    public String getBusinessType()             { return businessType; }
    public void   setBusinessType(String type)  { this.businessType = type; }

    @Override
    // Polymorphism
    public String getTypeIcon() {
        return "🏢";
    }
}