package com.realestate.portal.util;

import com.realestate.portal.model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

// Abstraction
public class UserDAO {

    // Constructor
    public UserDAO() {
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {
            try { stmt.execute("ALTER TABLE users ADD COLUMN phone VARCHAR(20)"); } catch (Exception e) {}
            try { stmt.execute("ALTER TABLE users ADD COLUMN address VARCHAR(255)"); } catch (Exception e) {}
            try { stmt.execute("ALTER TABLE users ADD COLUMN bio TEXT"); } catch (Exception e) {}
            try { stmt.execute("ALTER TABLE users ADD COLUMN profile_photo VARCHAR(255)"); } catch (Exception e) {}
        } catch (Exception e) {}
    }

    public boolean createUser(String name, String email, String password, String type) {
        String sql = "INSERT INTO users (name, email, password, type) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, type);
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int userId = generatedKeys.getInt(1);
                         if ("SELLER".equalsIgnoreCase(type)) {
                            SellerDAO sellerDAO = new SellerDAO();
                            String randomLicense = "LIC-" + (100000 + new java.util.Random().nextInt(900000));
                            // Junior seller by default, with random license number and mailing address set to null
                            sellerDAO.createSeller(userId, name + "'s Agency", "General", "junior", 0.0, randomLicense, null);
                        }
                    }
                }
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                users.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public User getUserById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public User findByEmail(String email) {
        if (email == null) return null;
        String sql = "SELECT * FROM users WHERE LOWER(email) = LOWER(?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email.trim());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<User> getUsersByType(String type) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE LOWER(type) = LOWER(?) ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, type);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) users.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public List<User> searchUsers(String keyword) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE name LIKE ? OR email LIKE ? ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String pattern = "%" + keyword + "%";
            ps.setString(1, pattern);
            ps.setString(2, pattern);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) users.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public boolean updateUser(int id, String name, String email, String password, String type) {
        try (Connection conn = DBConnection.getConnection()) {
            if (password != null && !password.isBlank()) {
                String sql = "UPDATE users SET name = ?, email = ?, password = ?, type = ? WHERE id = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, password);
                ps.setString(4, type);
                ps.setInt(5, id);
                return ps.executeUpdate() > 0;
            } else {
                String sql = "UPDATE users SET name = ?, email = ?, type = ? WHERE id = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, type);
                ps.setInt(4, id);
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateProfileDetails(int id, String phone, String address, String bio) {
        try (Connection conn = DBConnection.getConnection()) {
            DatabaseMetaData meta = conn.getMetaData();
            
            // Check which columns exist in users table
            boolean hasPhone = false;
            boolean hasContactPhone = false;
            boolean hasAddress = false;
            boolean hasMailingAddress = false;
            boolean hasBio = false;
            boolean hasPersonalBiography = false;
            
            try (ResultSet rs = meta.getColumns(null, null, "users", null)) {
                while (rs.next()) {
                    String columnName = rs.getString("COLUMN_NAME");
                    if ("phone".equalsIgnoreCase(columnName)) hasPhone = true;
                    if ("contact_phone".equalsIgnoreCase(columnName)) hasContactPhone = true;
                    if ("address".equalsIgnoreCase(columnName)) hasAddress = true;
                    if ("mailing_address".equalsIgnoreCase(columnName)) hasMailingAddress = true;
                    if ("bio".equalsIgnoreCase(columnName)) hasBio = true;
                    if ("personal_biography".equalsIgnoreCase(columnName)) hasPersonalBiography = true;
                }
            }
            
            StringBuilder sql = new StringBuilder("UPDATE users SET ");
            List<Object> params = new ArrayList<>();
            
            if (hasPhone) {
                sql.append("phone = ?, ");
                params.add(phone);
            }
            if (hasContactPhone) {
                sql.append("contact_phone = ?, ");
                params.add(phone);
            }
            if (hasAddress) {
                sql.append("address = ?, ");
                params.add(address);
            }
            if (hasMailingAddress) {
                sql.append("mailing_address = ?, ");
                params.add(address);
            }
            if (hasBio) {
                sql.append("bio = ?, ");
                params.add(bio);
            }
            if (hasPersonalBiography) {
                sql.append("personal_biography = ?, ");
                params.add(bio);
            }
            
            // Remove trailing comma and space
            if (params.isEmpty()) {
                return true; // nothing to update
            }
            sql.setLength(sql.length() - 2);
            sql.append(" WHERE id = ?");
            params.add(id);
            
            try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
                for (int i = 0; i < params.size(); i++) {
                    ps.setObject(i + 1, params.get(i));
                }
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateProfilePhoto(int id, String photoUrl) {
        String sql = "UPDATE users SET profile_photo = ? WHERE id = ?";
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

    public boolean deleteUser(int id) {
        int sellerId = -1;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT id FROM sellers WHERE seller_id = ?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    sellerId = rs.getInt("id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                // If they are a seller, clean up sellers-specific records first
                if (sellerId > 0) {
                    try (PreparedStatement ps = conn.prepareStatement("UPDATE sellers SET supervisor_id = NULL WHERE supervisor_id = ?")) {
                        ps.setInt(1, sellerId);
                        ps.executeUpdate();
                    }
                    try (PreparedStatement ps = conn.prepareStatement("DELETE FROM reviews WHERE target_type = 'Seller' AND target_id = ?")) {
                        ps.setInt(1, sellerId);
                        ps.executeUpdate();
                    }
                    try (PreparedStatement ps = conn.prepareStatement("DELETE FROM sellers WHERE id = ?")) {
                        ps.setInt(1, sellerId);
                        ps.executeUpdate();
                    }
                }

                // Delete properties and their dependencies
                List<Integer> propertyIds = new ArrayList<>();
                try (PreparedStatement ps = conn.prepareStatement("SELECT id FROM properties WHERE seller_id = ?")) {
                    ps.setInt(1, id);
                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            propertyIds.add(rs.getInt("id"));
                        }
                    }
                }

                for (int propId : propertyIds) {
                    try (PreparedStatement ps = conn.prepareStatement("DELETE FROM property_images WHERE property_id = ?")) {
                        ps.setInt(1, propId);
                        ps.executeUpdate();
                    }
                    try (PreparedStatement ps = conn.prepareStatement("DELETE FROM inquiries WHERE property_id = ?")) {
                        ps.setInt(1, propId);
                        ps.executeUpdate();
                    }
                    try (PreparedStatement ps = conn.prepareStatement("DELETE FROM reviews WHERE target_type = 'Property' AND target_id = ?")) {
                        ps.setInt(1, propId);
                        ps.executeUpdate();
                    }
                    try (PreparedStatement ps = conn.prepareStatement("DELETE FROM properties WHERE id = ?")) {
                        ps.setInt(1, propId);
                        ps.executeUpdate();
                    }
                }

                // Delete reviews created by this user
                try (PreparedStatement ps = conn.prepareStatement("DELETE FROM reviews WHERE reviewer_id = ?")) {
                    ps.setInt(1, id);
                    ps.executeUpdate();
                }

                // Delete inquiries created by this user
                try (PreparedStatement ps = conn.prepareStatement("DELETE FROM inquiries WHERE buyer_id = ?")) {
                    ps.setInt(1, id);
                    ps.executeUpdate();
                }

                // Finally delete from users table
                try (PreparedStatement ps = conn.prepareStatement("DELETE FROM users WHERE id = ?")) {
                    ps.setInt(1, id);
                    ps.executeUpdate();
                }

                conn.commit();
                return true;
            } catch (SQLException e) {
                conn.rollback();
                e.printStackTrace();
                return false;
            } finally {
                conn.setAutoCommit(true);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private User mapRow(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setName(rs.getString("name"));
        u.setEmail(rs.getString("email"));
        u.setPassword(rs.getString("password"));
        u.setType(rs.getString("type"));
        
        try {
            String p = rs.getString("phone");
            if (p == null || p.isBlank()) p = rs.getString("contact_phone");
            u.setPhone(p);
        } catch(Exception e){}
        try {
            String a = rs.getString("address");
            if (a == null || a.isBlank()) a = rs.getString("mailing_address");
            u.setAddress(a);
        } catch(Exception e){}
        try {
            String b = rs.getString("bio");
            if (b == null || b.isBlank()) b = rs.getString("personal_biography");
            u.setBio(b);
        } catch(Exception e){}
        try { u.setProfilePhoto(rs.getString("profile_photo")); } catch(Exception e){}
        
        u.setCreatedAt(rs.getString("created_at"));
        return u;
    }
}