package com.realestate.portal.model;

/**
 * MEMBER 6 — PropertyReview
 * OOP: Inheritance  — extends Review
 * OOP: Polymorphism — @Override getTargetLabel()
 */
public class PropertyReview extends Review {

    private int locationRating; // 1–5 extra rating for location

    public PropertyReview() {
        super();
        setTargetType("property");
    }

    public int  getLocationRating()          { return locationRating; }
    public void setLocationRating(int lr)    { this.locationRating = lr; }

    @Override
    public String getTargetLabel() {
        return "Property #" + getTargetId();
    }
}
