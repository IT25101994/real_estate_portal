package com.realestate.portal.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
            "jdbc:mysql://gateway01.ap-southeast-1.prod.alicloud.tidbcloud.com:4000/real_estate_db"
                    + "?useSSL=true&sslMode=VERIFY_IDENTITY";
    private static final String USERNAME = "2yEpC3jf54XfQAY.root";
    private static final String PASSWORD = "c9QYSIQWpSGorMND";

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL Driver not found — check pom.xml", e);
        } catch (SQLException e) {
            throw new RuntimeException("DB connection failed — check MySQL is running", e);
        }
    }

    private DBConnection() {}
}