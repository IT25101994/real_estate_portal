package com.realestate.portal.model;

// Inheritance
public class PropertyReview extends Review {

    // Information hiding
    private int locationRating; // 1–5 extra rating for location

    // Constructor
    public PropertyReview() {
        super();
        setTargetType("property");
    }

    // Encapsulation
    public int  getLocationRating()          { return locationRating; }
    public void setLocationRating(int lr)    { this.locationRating = lr; }

    @Override
    // Polymorphism
    public String getTargetLabel() {
        return "Property #" + getTargetId();
    }
}
