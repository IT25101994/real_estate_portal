package com.realestate.portal.model;

public class Property {

    // Information hiding
    private int    id;
    private int    sellerId;
    private String sellerName;
    private String title;
    private String location;
    private double price;
    private String type;
    private int    bedrooms;
    private String status;
    private String description;
    private String createdAt;
    private String imageUrl;
    private java.util.List<String> galleryImages;
    private String sellerPhoto;

    // Constructor
    public Property() {
        this.galleryImages = new java.util.ArrayList<>();
    }

    // Encapsulation
    public String getSellerPhoto()             { return sellerPhoto; }
    public void   setSellerPhoto(String a)     { this.sellerPhoto = a; }

    public Property(int id, int sellerId, String title, String location,
                    double price, String type, int bedrooms,
                    String status, String description, String createdAt, String imageUrl) {
        this.id          = id;
        this.sellerId     = sellerId;
        this.title       = title;
        this.location    = location;
        this.price       = price;
        this.type        = type;
        this.bedrooms    = bedrooms;
        this.status      = status;
        this.description = description;
        this.createdAt   = createdAt;
        this.imageUrl    = imageUrl;
        this.galleryImages = new java.util.ArrayList<>();
    }

    public int    getId()                  { return id; }
    public void   setId(int id)            { this.id = id; }
    public int    getSellerId()             { return sellerId; }
    public void   setSellerId(int a)        { this.sellerId = a; }
    public String getSellerName()           { return sellerName; }
    public void   setSellerName(String a)   { this.sellerName = a; }
    public String getTitle()               { return title; }
    public void   setTitle(String t)       { this.title = t; }
    public String getLocation()            { return location; }
    public void   setLocation(String l)    { this.location = l; }
    public double getPrice()               { return price; }
    public void   setPrice(double p)       { this.price = p; }
    public String getType()                { return type; }
    public void   setType(String t)        { this.type = t; }
    public int    getBedrooms()            { return bedrooms; }
    public void   setBedrooms(int b)       { this.bedrooms = b; }
    public String getStatus()              { return status; }
    public void   setStatus(String s)      { this.status = s; }
    public String getDescription()         { return description; }
    public void   setDescription(String d) { this.description = d; }
    public String getCreatedAt()           { return createdAt; }
    public void   setCreatedAt(String c)   { this.createdAt = c; }
    public String getImageUrl()            { return imageUrl; }
    public void   setImageUrl(String i)    { this.imageUrl = i; }

    public java.util.List<String> getGalleryImages() { return galleryImages; }
    public void setGalleryImages(java.util.List<String> g) { this.galleryImages = g; }

    public String getTypeIcon() {
        if ("Commercial".equalsIgnoreCase(type)) return "\uD83C\uDFE2";
        return "\uD83C\uDFE0";
    }
}