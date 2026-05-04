package com.realestate.portal.model;

/**
 * MEMBER 1 — User (Base Class)
 * OOP: Encapsulation — all fields are private, accessed via getters/setters
 * OOP: Polymorphism  — getWelcomeMessage() is overridden in subclasses
 */
public class User {

    // Encapsulation: private fields
    private int    id;
    private String name;
    private String email;
    private String password;
    private String type;       // "buyer" or "seller"
    private String phone;
    private String address;
    private String bio;
    private String createdAt;
    private String profilePhoto; // URL/path to the profile image

    // ── Constructors ──────────────────────────────────────────────────────
    public User() {}

    public User(int id, String name, String email, String password, String type, String phone, String address, String bio, String createdAt) {
        this.id        = id;
        this.name      = name;
        this.email     = email;
        this.password  = password;
        this.type      = type;
        this.phone     = phone;
        this.address   = address;
        this.bio       = bio;
        this.createdAt = createdAt;
    }

    // ── Getters & Setters (Encapsulation) ─────────────────────────────────
    public int    getId()        { return id; }
    public void   setId(int id)  { this.id = id; }

    public String getName()             { return name; }
    public void   setName(String name)  { this.name = name; }

    public String getEmail()              { return email; }
    public void   setEmail(String email)  { this.email = email; }

    public String getPassword()                 { return password; }
    public void   setPassword(String password)  { this.password = password; }

    public String getType()             { return type; }
    public void   setType(String type)  { this.type = type; }

    public String getPhone()               { return phone; }
    public void   setPhone(String phone)   { this.phone = phone; }

    public String getAddress()                 { return address; }
    public void   setAddress(String address)   { this.address = address; }

    public String getBio()             { return bio; }
    public void   setBio(String bio)   { this.bio = bio; }

    public String getCreatedAt()                  { return createdAt; }
    public void   setCreatedAt(String createdAt)  { this.createdAt = createdAt; }

    public String getProfilePhoto()                     { return profilePhoto; }
    public void   setProfilePhoto(String profilePhoto)  { this.profilePhoto = profilePhoto; }

    // ── Polymorphic method — overridden in subclasses ─────────────────────
    public String getWelcomeMessage() {
        return "Welcome, " + name + "!";
    }

    @Override
    public String toString() {
        return "User{id=" + id + ", name=" + name + ", email=" + email + ", type=" + type + "}";
    }
}
