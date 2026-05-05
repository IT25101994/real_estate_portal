package com.realestate.portal.model;

public class CommercialProperty extends Property {

    private String businessType;

    public CommercialProperty() {
        super();
    }

    public String getBusinessType()             { return businessType; }
    public void   setBusinessType(String type)  { this.businessType = type; }

    @Override
    public String getTypeIcon() {
        return "🏢";
    }
}