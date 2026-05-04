package com.realestate.portal.model;

/**
 * MEMBER 5 — SeniorSeller
 * OOP: Inheritance  — extends Seller
 * OOP: Polymorphism — getMaxListings() returns 20
 */
public class SeniorSeller extends Seller {

    public SeniorSeller() {
        super();
        setTier("senior");
    }

    @Override
    public int getMaxListings() { return 20; }

    @Override
    public String getTierBadge() { return "bg-success"; }
}
