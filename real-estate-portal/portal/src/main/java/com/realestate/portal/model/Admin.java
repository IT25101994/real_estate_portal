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

    // Polymorphism
    public boolean isCanDeleteUsers()   { return false; }
    public boolean isCanManageAdmins()  { return false; }

    public String getRoleBadgeClass() {
        return "superadmin".equals(role) ? "bg-danger" : "bg-secondary";
    }
}
