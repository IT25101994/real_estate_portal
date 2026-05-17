package com.realestate.portal.model;

// Inheritance
public class SellerReview extends Review {

    // Information hiding
    private int communicationRating; // 1–5

    // Constructor
    public SellerReview() {
        super();
        setTargetType("seller");
    }

    // Encapsulation
    public int  getCommunicationRating()       { return communicationRating; }
    public void setCommunicationRating(int cr) { this.communicationRating = cr; }

    @Override
    // Polymorphism
    public String getTargetLabel() {
        return "Seller #" + getTargetId();
    }
}
