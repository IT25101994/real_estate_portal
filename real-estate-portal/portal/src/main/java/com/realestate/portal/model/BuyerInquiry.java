package com.realestate.portal.model;

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
