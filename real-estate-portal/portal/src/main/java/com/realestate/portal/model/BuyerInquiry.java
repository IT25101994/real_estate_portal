package com.realestate.portal.model;

/**
 * MEMBER 3 — BuyerInquiry (Subclass)
 * OOP: Inheritance  — extends Inquiry
 * OOP: Polymorphism — @Override getStatusLabel() with urgency
 */
public class BuyerInquiry extends Inquiry {

    private String urgencyLevel; // "low", "medium", "high"

    public BuyerInquiry() { super(); }

    public String getUrgencyLevel()               { return urgencyLevel; }
    public void   setUrgencyLevel(String level)   { this.urgencyLevel = level; }

    @Override
    public String getStatusLabel() {
        String base = super.getStatusLabel();
        if ("high".equals(urgencyLevel)) return base + " (URGENT)";
        return base;
    }
}
