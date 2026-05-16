package com.realestate.portal.model;

public class SellerReview extends Review {

    private int communicationRating; // 1–5

    public SellerReview() {
        super();
        setTargetType("seller");
    }

    public int  getCommunicationRating()       { return communicationRating; }
    public void setCommunicationRating(int cr) { this.communicationRating = cr; }

    @Override
    public String getTargetLabel() {
        return "Seller #" + getTargetId();
    }
}
