package com.realestate.portal.model;

/**
 * MEMBER 1 — SellerUser (Subclass)
 * OOP: Inheritance   — extends User
 * OOP: Polymorphism  — @Override getWelcomeMessage() returns seller-specific text
 */
public class SellerUser extends User {

    private String licenseNumber;

    public SellerUser() {
        super();
    }

    public SellerUser(int id, String name, String email, String password, String createdAt,
                     String licenseNumber) {
        super(id, name, email, password, "seller", null, null, null, createdAt);
        this.licenseNumber = licenseNumber;
    }

    public String getLicenseNumber()                      { return licenseNumber; }
    public void   setLicenseNumber(String licenseNumber)  { this.licenseNumber = licenseNumber; }

    @Override
    public String getWelcomeMessage() {
        return "Welcome Seller, " + getName() + "! Manage your property listings here.";
    }
}
