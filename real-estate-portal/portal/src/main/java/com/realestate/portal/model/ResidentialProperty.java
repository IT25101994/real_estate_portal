package com.realestate.portal.model;

// Inheritance
public class ResidentialProperty extends Property {

    // Information hiding
    private String furnishedStatus;

    // Constructor
    public ResidentialProperty() {
        super();
    }

    // Encapsulation
    public String getFurnishedStatus()               { return furnishedStatus; }
    public void   setFurnishedStatus(String status)  { this.furnishedStatus = status; }

    @Override
    // Polymorphism
    public String getTypeIcon() {
        return "🏡";
    }
}