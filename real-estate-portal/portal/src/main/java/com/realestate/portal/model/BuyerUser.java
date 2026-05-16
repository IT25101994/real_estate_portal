package com.realestate.portal.model;

public class BuyerUser extends User {

    // Extra field specific to buyers
    private String preferredLocation;

    // Constructors
    public BuyerUser() {
        super();
    }

    public BuyerUser(int id, String name, String email, String password, String createdAt,
                     String preferredLocation) {
        super(id, name, email, password, "buyer", null, null, null, createdAt);
        this.preferredLocation = preferredLocation;
    }

    // Getter & Setter
    public String getPreferredLocation()                        { return preferredLocation; }
    public void   setPreferredLocation(String preferredLocation){ this.preferredLocation = preferredLocation; }

    // Polymorphism: different welcome message for buyers
    @Override
    public String getWelcomeMessage() {
        return "Welcome Buyer, " + getName() + "! Browse available properties below.";
    }
}
