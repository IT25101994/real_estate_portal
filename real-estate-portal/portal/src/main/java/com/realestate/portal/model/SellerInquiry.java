package com.realestate.portal.model;

public class SellerInquiry extends Inquiry {

    private String responseDate;
    private String sellerNotes;

    public SellerInquiry() { super(); }

    public String getResponseDate()               { return responseDate; }
    public void   setResponseDate(String date)    { this.responseDate = date; }
    public String getSellerNotes()                { return sellerNotes; }
    public void   setSellerNotes(String notes)    { this.sellerNotes = notes; }

    @Override
    public String getStatusLabel() {
        if ("responded".equals(getStatus()) && responseDate != null)
            return "Responded on " + responseDate;
        return super.getStatusLabel();
    }
}
