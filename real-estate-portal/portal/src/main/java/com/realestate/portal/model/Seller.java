package com.realestate.portal.model;

public class Seller {
    // Information hiding
    private int    id;
    private int    userId;
    private String userName;      // from JOIN with users
    private String agencyName;
    private String specialization;
    private String tier;          // "senior" or "junior"
    private double rating;
    private String createdAt;
    private String licenseNumber;
    private String contactPhone;
    private String mailingAddress;
    private String personalBiography;

    // Constructor
    public Seller() {}

    // Encapsulation
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
    public String getLicenseNumber()     { return licenseNumber; }
    public void   setLicenseNumber(String l) { this.licenseNumber = l; }
    public String getContactPhone()      { return contactPhone; }
    public void   setContactPhone(String cp) { this.contactPhone = cp; }
    public String getMailingAddress()    { return mailingAddress; }
    public void   setMailingAddress(String ma) { this.mailingAddress = ma; }
    public String getPersonalBiography() { return personalBiography; }
    public void   setPersonalBiography(String pb) { this.personalBiography = pb; }

    // Polymorphism
    public int getMaxListings() { return 10; }  // default
    public String getTierBadge() { return "bg-secondary"; }
}
