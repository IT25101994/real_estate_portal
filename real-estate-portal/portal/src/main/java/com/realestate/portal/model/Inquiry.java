package com.realestate.portal.model;

/**
 * MEMBER 3 — Inquiry (Base Class)
 */
public class Inquiry {
    private int    id;
    private int    buyerId;
    private String buyerName;    // from JOIN
    private int    propertyId;
    private String propertyTitle; // from JOIN
    private String message;
    private String response;
    private String status;       // "pending", "responded", "closed"
    private String createdAt;

    public Inquiry() {}

    // Getters & Setters
    public int    getId()                     { return id; }
    public void   setId(int id)               { this.id = id; }
    public int    getBuyerId()                { return buyerId; }
    public void   setBuyerId(int b)           { this.buyerId = b; }
    public String getBuyerName()              { return buyerName; }
    public void   setBuyerName(String b)      { this.buyerName = b; }
    public int    getPropertyId()             { return propertyId; }
    public void   setPropertyId(int p)        { this.propertyId = p; }
    public String getPropertyTitle()          { return propertyTitle; }
    public void   setPropertyTitle(String pt) { this.propertyTitle = pt; }
    public String getMessage()                { return message; }
    public void   setMessage(String m)        { this.message = m; }
    public String getResponse()               { return response; }
    public void   setResponse(String r)       { this.response = r; }
    public String getStatus()                 { return status; }
    public void   setStatus(String s)         { this.status = s; }
    public String getCreatedAt()              { return createdAt; }
    public void   setCreatedAt(String c)      { this.createdAt = c; }

    // Polymorphic method
    public String getStatusLabel() {
        return switch (status == null ? "pending" : status) {
            case "responded" -> "Responded";
            case "closed"    -> "Closed";
            default          -> "Pending";
        };
    }

    public String getStatusBadgeClass() {
        return switch (status == null ? "pending" : status) {
            case "responded" -> "bg-success";
            case "closed"    -> "bg-secondary";
            default          -> "bg-warning text-dark";
        };
    }
}
