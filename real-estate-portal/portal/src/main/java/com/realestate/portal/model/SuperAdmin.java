package com.realestate.portal.model;

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
