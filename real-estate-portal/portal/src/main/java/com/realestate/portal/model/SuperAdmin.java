package com.realestate.portal.model;

/**
 * MEMBER 4 — SuperAdmin
 * OOP: Inheritance  — extends Admin
 * OOP: Polymorphism — overrides permission methods to return true
 */
public class SuperAdmin extends Admin {

    public SuperAdmin() {
        super();
        setRole("superadmin");
    }

    @Override
    public boolean isCanDeleteUsers()   { return true; }

    @Override
    public boolean isCanManageAdmins()  { return true; }
}
