package com.realestate.portal.model;

// Inheritance
public class BuyerUser extends User {

    // Information hiding
    private String preferredLocation;

    // Constructor
    public BuyerUser() {
        super();
    }

    public BuyerUser(int id, String name, String email, String password, String createdAt,
                     String preferredLocation) {
        super(id, name, email, password, "buyer", null, null, null, createdAt);
        this.preferredLocation = preferredLocation;
    }

    // Encapsulation
    public String getPreferredLocation()                        { return preferredLocation; }
    public void   setPreferredLocation(String preferredLocation){ this.preferredLocation = preferredLocation; }

    @Override
    // Polymorphism
    public String getWelcomeMessage() {
        return "Welcome Buyer, " + getName() + "! Browse available properties below.";
    }
}
