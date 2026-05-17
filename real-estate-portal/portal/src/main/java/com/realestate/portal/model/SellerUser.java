package com.realestate.portal.model;

// Inheritance
public class SellerUser extends User {

    // Information hiding
    private String licenseNumber;

    // Constructor
    public SellerUser() {
        super();
    }

    public SellerUser(int id, String name, String email, String password, String createdAt,
                     String licenseNumber) {
        super(id, name, email, password, "seller", null, null, null, createdAt);
        this.licenseNumber = licenseNumber;
    }

    // Encapsulation
    public String getLicenseNumber()                      { return licenseNumber; }
    public void   setLicenseNumber(String licenseNumber)  { this.licenseNumber = licenseNumber; }

    @Override
    // Polymorphism
    public String getWelcomeMessage() {
        return "Welcome Seller, " + getName() + "! Manage your property listings here.";
    }
}
