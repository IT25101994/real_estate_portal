package com.realestate.portal.model;

// Inheritance
public class JuniorSeller extends Seller {

    // Constructor
    public JuniorSeller() {
        super();
        setTier("junior");
    }

    @Override
    // Polymorphism
    public int getMaxListings() { return 5; }

    @Override
    public String getTierBadge() { return "bg-info text-dark"; }
}
