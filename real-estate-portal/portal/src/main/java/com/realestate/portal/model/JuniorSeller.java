package com.realestate.portal.model;

// Inheritance
public class JuniorSeller extends Seller {

    // Information hiding
    private int supervisorId;

    // Constructor
    public JuniorSeller() {
        super();
        setTier("junior");
    }

    // Encapsulation
    public int  getSupervisorId()          { return supervisorId; }
    public void setSupervisorId(int sid)   { this.supervisorId = sid; }

    @Override
    // Polymorphism
    public int getMaxListings() { return 5; }

    @Override
    public String getTierBadge() { return "bg-info text-dark"; }
}
