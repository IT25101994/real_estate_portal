package com.realestate.portal.model;

/**
 * MEMBER 5 — JuniorSeller
 * getMaxListings() returns only 5. Has a supervisorId.
 */
public class JuniorSeller extends Seller {

    private int supervisorId;

    public JuniorSeller() {
        super();
        setTier("junior");
    }

    public int  getSupervisorId()          { return supervisorId; }
    public void setSupervisorId(int sid)   { this.supervisorId = sid; }

    @Override
    public int getMaxListings() { return 5; }

    @Override
    public String getTierBadge() { return "bg-info text-dark"; }
}
