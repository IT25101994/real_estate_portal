package com.realestate.portal.model;

public class Review {
    // Information hiding
    private int    id;
    private int    userId;
    private String userName;     // from JOIN
    private int    targetId;
    private String targetType;   // "property" or "seller"
    private int    rating;       // 1–5
    private String comment;
    private String createdAt;
    private String userPhoto;    // from JOIN

    // Constructor
    public Review() {}

    // Encapsulation
    public int    getId()                { return id; }
    public void   setId(int id)          { this.id = id; }
    public int    getUserId()            { return userId; }
    public void   setUserId(int u)       { this.userId = u; }
    public String getUserName()          { return userName; }
    public void   setUserName(String u)  { this.userName = u; }
    public String getUserPhoto()         { return userPhoto; }
    public void   setUserPhoto(String p) { this.userPhoto = p; }
    public int    getTargetId()          { return targetId; }
    public void   setTargetId(int t)     { this.targetId = t; }
    public String getTargetType()        { return targetType; }
    public void   setTargetType(String t){ this.targetType = t; }
    public int    getRating()            { return rating; }
    public void   setRating(int r)       { this.rating = r; }
    public String getComment()           { return comment; }
    public void   setComment(String c)   { this.comment = c; }
    public String getCreatedAt()         { return createdAt; }
    public void   setCreatedAt(String c) { this.createdAt = c; }

    public String getStars() {
        StringBuilder sb = new StringBuilder();
        for (int i = 1; i <= 5; i++) sb.append(i <= rating ? "★" : "☆");
        return sb.toString();
    }

    // Polymorphism
    public String getTargetLabel() {
        return "Target #" + targetId;
    }
}
