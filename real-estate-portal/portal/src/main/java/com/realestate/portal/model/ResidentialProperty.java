package com.realestate.portal.model;

public class ResidentialProperty extends Property {

    private String furnishedStatus;

    public ResidentialProperty() {
        super();
    }

    public String getFurnishedStatus()               { return furnishedStatus; }
    public void   setFurnishedStatus(String status)  { this.furnishedStatus = status; }

    @Override
    public String getTypeIcon() {
        return "🏡";
    }
}