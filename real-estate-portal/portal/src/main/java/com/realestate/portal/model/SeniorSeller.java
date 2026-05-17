package com.realestate.portal.model;

// Inheritance
public class SeniorSeller extends Seller {

    // Constructor
    public SeniorSeller() {
        super();
        setTier("senior");
    }

    @Override
    // Polymorphism
    public int getMaxListings() { return 20; }

    @Override
    public String getTierBadge() { return "bg-success"; }
}
