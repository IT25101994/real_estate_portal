package com.realestate.portal.model;

/**
 * MEMBER 4 — ModeratorAdmin
 * Restricted access — cannot delete users or manage other admins.
 */
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
