package com.realestate.portal.model;

// Inheritance
public class BuyerInquiry extends Inquiry {

    // Information hiding
    private String urgencyLevel;

    // Constructor
    public BuyerInquiry() { super(); }

    // Encapsulation
    public String getUrgencyLevel()               { return urgencyLevel; }
    public void   setUrgencyLevel(String level)   { this.urgencyLevel = level; }

    @Override
    // Polymorphism
    public String getStatusLabel() {
        String base = super.getStatusLabel();
        if ("high".equals(urgencyLevel)) return base + " (URGENT)";
        return base;
    }
}
