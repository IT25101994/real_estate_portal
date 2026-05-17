package com.realestate.portal.model;

// Inheritance
public class SellerInquiry extends Inquiry {

    // Information hiding
    private String responseDate;
    private String sellerNotes;

    // Constructor
    public SellerInquiry() { super(); }

    // Encapsulation
    public String getResponseDate()               { return responseDate; }
    public void   setResponseDate(String date)    { this.responseDate = date; }
    public String getSellerNotes()                { return sellerNotes; }
    public void   setSellerNotes(String notes)    { this.sellerNotes = notes; }

    @Override
    // Polymorphism
    public String getStatusLabel() {
        if ("responded".equals(getStatus()) && responseDate != null)
            return "Responded on " + responseDate;
        return super.getStatusLabel();
    }
}
