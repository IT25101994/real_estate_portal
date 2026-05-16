package com.realestate.portal.model;

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
