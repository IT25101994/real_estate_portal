package com.realestate.portal.model;

// Inheritance
public class SuperAdmin extends Admin {

    // Constructor
    public SuperAdmin() {
        super();
        setRole("superadmin");
    }

    @Override
    // Polymorphism
    public boolean isCanDeleteUsers()   { return true; }

    @Override
    public boolean isCanManageAdmins()  { return true; }
}
