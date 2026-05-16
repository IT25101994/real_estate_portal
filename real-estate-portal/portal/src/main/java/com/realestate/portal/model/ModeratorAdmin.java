package com.realestate.portal.model;

public class ModeratorAdmin extends Admin {

    public ModeratorAdmin() {
        super();
        setRole("moderator");
    }

    @Override
    public boolean isCanDeleteUsers()   { return false; }

    @Override
    public boolean isCanManageAdmins()  { return false; }
}
