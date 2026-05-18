package com.realestate.portal.model;

public class Admin {
    // Information hiding
    private int    id;
    private String name;
    private String email;
    private String password;
    private String role;
    private String createdAt;
    private String profilePhoto;
    private String contactPhone;
    private String mailingAddress;
    private String personalBiography;

    // Constructor
    public Admin() {}

    // Encapsulation
    public int    getId()               { return id; }
    public void   setId(int id)         { this.id = id; }
    public String getName()             { return name; }
    public void   setName(String n)     { this.name = n; }
    public String getEmail()            { return email; }
    public void   setEmail(String e)    { this.email = e; }
    public String getPassword()         { return password; }
    public void   setPassword(String p) { this.password = p; }
    public String getRole()             { return role; }
    public void   setRole(String r)     { this.role = r; }
    public String getCreatedAt()        { return createdAt; }
    public void   setCreatedAt(String c){ this.createdAt = c; }
    public String getProfilePhoto()             { return profilePhoto; }
    public void   setProfilePhoto(String p)     { this.profilePhoto = p; }
    public String getContactPhone()             { return contactPhone; }
    public void   setContactPhone(String c)     { this.contactPhone = c; }
    public String getMailingAddress()           { return mailingAddress; }
    public void   setMailingAddress(String m)   { this.mailingAddress = m; }
    public String getPersonalBiography()        { return personalBiography; }
    public void   setPersonalBiography(String p) { this.personalBiography = p; }

    // Polymorphism
    public boolean isCanDeleteUsers()   { return false; }
    public boolean isCanManageAdmins()  { return false; }

    public String getRoleBadgeClass() {
        return "superadmin".equals(role) ? "bg-danger" : "bg-secondary";
    }
}
