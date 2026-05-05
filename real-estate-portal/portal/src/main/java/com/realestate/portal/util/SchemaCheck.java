package com.realestate.portal.util;
import java.sql.*;
public class SchemaCheck {
    public static void main(String[] args) throws Exception {
        try (Connection c = DBConnection.getConnection();
             Statement s = c.createStatement();
             ResultSet rs = s.executeQuery("DESCRIBE properties")) {
            while (rs.next()) {
                if (rs.getString("Field").equals("status")) {
                    System.out.println("Status column type: " + rs.getString("Type"));
                }
            }
        }
    }
}
