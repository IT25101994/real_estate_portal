package com.realestate.portal.util;

import java.sql.*;

public class RefactorDB {
    public static void main(String[] args) {
        try (Connection c = DBConnection.getConnection();
             Statement s = c.createStatement()) {
            
            System.out.println("Applying database schema rename from agent to seller...");
            
            try {
                s.execute("ALTER TABLE agents RENAME TO sellers");
                System.out.println("Renamed table agents -> sellers");
            } catch (Exception e) { System.out.println(e.getMessage()); }
            
            try {
                s.execute("ALTER TABLE properties RENAME COLUMN agent_id TO seller_id");
                System.out.println("Renamed properties.agent_id -> properties.seller_id");
            } catch (Exception e) { System.out.println(e.getMessage()); }
            
            try {
                int updated = s.executeUpdate("UPDATE users SET type = 'seller' WHERE type = 'agent'");
                System.out.println("Updated users table agent to seller. Rows modified: " + updated);
            } catch (Exception e) { System.out.println(e.getMessage()); }

            System.out.println("Database refactor complete.");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
