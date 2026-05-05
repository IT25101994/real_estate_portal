package com.realestate.portal.util;

import com.realestate.portal.model.Admin;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * MEMBER 4 — AdminDAO
 */
public class AdminDAO {
    
    public AdminDAO() {
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {
            try { stmt.execute("ALTER TABLE admins ADD COLUMN profile_photo VARCHAR(255)"); } catch (Exception e) {}
        } catch (Exception e) {}
    }

    public boolean createAdmin(String name, String email, String password, String role) {
        String sql = "INSERT INTO admins (name, email, password, role) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name); ps.setString(2, email);
            ps.setString(3, password); ps.setString(4, role);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public List<Admin> getAllAdmins() {
        List<Admin> list = new ArrayList<>();
        String sql = "SELECT * FROM admins ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public Admin getById(int id) {
        String sql = "SELECT * FROM admins WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) { if (rs.next()) return mapRow(rs); }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public Admin findByEmail(String email) {
        String sql = "SELECT * FROM admins WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) { if (rs.next()) return mapRow(rs); }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public boolean updateAdmin(int id, String name, String email, String role) {
        String sql = "UPDATE admins SET name=?, email=?, role=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name); ps.setString(2, email);
            ps.setString(3, role); ps.setInt(4, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean deleteAdmin(int id) {
        String sql = "DELETE FROM admins WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    /** Dashboard stat: SELECT COUNT(*) FROM tableName */
    public int countTable(String tableName) {
        // Table name is hardcoded in our code — never from user input — so safe
        String sql = "SELECT COUNT(*) FROM " + tableName;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    private Admin mapRow(ResultSet rs) throws SQLException {
        String role = rs.getString("role");
        Admin a;
        if ("superadmin".equalsIgnoreCase(role)) {
            a = new com.realestate.portal.model.SuperAdmin();
        } else if ("moderator".equalsIgnoreCase(role)) {
            a = new com.realestate.portal.model.ModeratorAdmin();
        } else {
            a = new Admin();
            a.setRole(role);
        }

        a.setId(rs.getInt("id"));
        a.setName(rs.getString("name"));
        a.setEmail(rs.getString("email"));
        a.setPassword(rs.getString("password"));
        if (!"superadmin".equalsIgnoreCase(role) && !"moderator".equalsIgnoreCase(role)) {
            a.setRole(role);
        }
        a.setCreatedAt(rs.getString("created_at"));
        try { a.setProfilePhoto(rs.getString("profile_photo")); } catch(Exception e){}
        return a;
    }

    public boolean updateProfilePhoto(int id, String photoUrl) {
        String sql = "UPDATE admins SET profile_photo = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, photoUrl);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
