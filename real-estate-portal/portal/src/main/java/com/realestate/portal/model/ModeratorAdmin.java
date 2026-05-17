package com.realestate.portal.model;

// Inheritance
public class ModeratorAdmin extends Admin {

    // Constructor
    public ModeratorAdmin() {
        super();
        setRole("moderator");
    }

    @Override
    // Polymorphism
    public boolean isCanDeleteUsers()   { return false; }

    @Override
    public boolean isCanManageAdmins()  { return false; }
}
