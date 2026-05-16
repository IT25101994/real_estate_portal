package com.realestate.portal.model;

public class Seller {
    private int    id;
    private int    userId;
    private String userName;      // from JOIN with users
    private String agencyName;
    private String specialization;
    private String tier;          // "senior" or "junior"
    private double rating;
    private String createdAt;

    public Seller() {}

    public int    getId()                { return id; }
    public void   setId(int id)          { this.id = id; }
    public int    getUserId()            { return userId; }
    public void   setUserId(int u)       { this.userId = u; }
    public String getUserName()          { return userName; }
    public void   setUserName(String u)  { this.userName = u; }
    public String getAgencyName()        { return agencyName; }
    public void   setAgencyName(String a){ this.agencyName = a; }
    public String getSpecialization()    { return specialization; }
    public void   setSpecialization(String s){ this.specialization = s; }
    public String getTier()              { return tier; }
    public void   setTier(String t)      { this.tier = t; }
    public double getRating()            { return rating; }
    public void   setRating(double r)    { this.rating = r; }
    public String getCreatedAt()         { return createdAt; }
    public void   setCreatedAt(String c) { this.createdAt = c; }

    // Polymorphic methods — overridden in subclasses
    public int getMaxListings() { return 10; }  // default
    public String getTierBadge() { return "bg-secondary"; }
}
