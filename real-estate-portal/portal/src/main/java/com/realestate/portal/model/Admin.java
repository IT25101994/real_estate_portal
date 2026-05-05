package com.realestate.portal.model;

/**
 * MEMBER 4 — Admin (Base Class)
 * OOP: Polymorphism — canDeleteUsers() and canManageAdmins() overridden in subclasses
 */
public class Admin {
    private int    id;
    private String name;
    private String email;
    private String password;
    private String role;       // "superadmin" or "moderator"
    private String createdAt;

    public Admin() {}

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

    private String profilePhoto;
    public String getProfilePhoto()             { return profilePhoto; }
    public void   setProfilePhoto(String p)     { this.profilePhoto = p; }

    // Polymorphic permission methods — overridden in subclasses
    public boolean isCanDeleteUsers()   { return false; }
    public boolean isCanManageAdmins()  { return false; }

    public String getRoleBadgeClass() {
        return "superadmin".equals(role) ? "bg-danger" : "bg-secondary";
    }
}
