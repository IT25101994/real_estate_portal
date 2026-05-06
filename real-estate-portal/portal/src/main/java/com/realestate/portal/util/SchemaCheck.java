package com.realestate.portal.util;
import java.sql.*;
public class SchemaCheck {
    public static void main(String[] args) throws Exception {
        try (Connection c = DBConnection.getConnection();
             Statement s = c.createStatement();
             ResultSet rs = s.executeQuery("DESCRIBE sellers")) {
            System.out.println("Columns in 'sellers' table:");
            while (rs.next()) {
                System.out.println("- " + rs.getString("Field") + " (" + rs.getString("Type") + ")");
            }
        }
    }
}
