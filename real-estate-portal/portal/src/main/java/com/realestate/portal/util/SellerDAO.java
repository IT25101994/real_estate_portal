package com.realestate.portal.util;

import com.realestate.portal.model.Seller;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

// Abstraction
public class SellerDAO {

    // Constructor
    public SellerDAO() {
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.execute("ALTER TABLE sellers ADD COLUMN rating DOUBLE DEFAULT 0.0");
        } catch (Exception ignored) {
            // column rating might already exist or other error
        }
    }

    public boolean createSeller(int userId, String agencyName, String specialization, String tier, double rating, String licenseNumber, String mailingAddress) {
        String sql = "INSERT INTO sellers (seller_id, seller_name, specialization, tier, rating, license_number, mailing_address) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId); ps.setString(2, agencyName);
            ps.setString(3, specialization); ps.setString(4, tier); ps.setDouble(5, rating);
            ps.setString(6, licenseNumber); ps.setString(7, mailingAddress);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public List<Seller> getAllSellers() {
        List<Seller> list = new ArrayList<>();
        String sql = "SELECT a.*, u.name AS user_name FROM sellers a "
                   + "LEFT JOIN users u ON a.seller_id = u.id ORDER BY a.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public List<Seller> searchSellers(String keyword) {
        List<Seller> list = new ArrayList<>();
        String sql = "SELECT a.*, u.name AS user_name FROM sellers a "
                   + "LEFT JOIN users u ON a.seller_id = u.id "
                   + "WHERE u.name LIKE ? OR a.seller_name LIKE ? OR a.specialization LIKE ? "
                   + "ORDER BY a.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String p = "%" + keyword + "%";
            ps.setString(1, p); ps.setString(2, p); ps.setString(3, p);
            try (ResultSet rs = ps.executeQuery()) { while (rs.next()) list.add(mapRow(rs)); }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public Seller getById(int id) {
        String sql = "SELECT a.*, u.name AS user_name FROM sellers a "
                   + "LEFT JOIN users u ON a.seller_id = u.id WHERE a.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) { if (rs.next()) return mapRow(rs); }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public Seller getByUserId(int userId) {
        String sql = "SELECT a.*, u.name AS user_name FROM sellers a "
                   + "LEFT JOIN users u ON a.seller_id = u.id WHERE a.seller_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) { if (rs.next()) return mapRow(rs); }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public List<Seller> getSeniorSellers() {
        List<Seller> list = new ArrayList<>();
        String sql = "SELECT a.*, u.name AS user_name FROM sellers a "
                   + "LEFT JOIN users u ON a.seller_id = u.id WHERE LOWER(a.tier) = 'senior' ORDER BY u.name ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }



    public boolean updateSeller(int id, String agencyName, String specialization, String tier) {
        String sql = "UPDATE sellers SET seller_name=?, specialization=?, tier=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, agencyName); ps.setString(2, specialization);
            ps.setString(3, tier); ps.setInt(4, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean deleteSeller(int id) {
        int userId = -1;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT seller_id FROM sellers WHERE id = ?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    userId = rs.getInt("seller_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                // 1. Update any other sellers reporting to this seller: set supervisor_id = NULL
                try (PreparedStatement ps = conn.prepareStatement("UPDATE sellers SET supervisor_id = NULL WHERE supervisor_id = ?")) {
                    ps.setInt(1, id);
                    ps.executeUpdate();
                }

                // 2. Delete reviews targeting this seller
                try (PreparedStatement ps = conn.prepareStatement("DELETE FROM reviews WHERE target_type = 'Seller' AND target_id = ?")) {
                    ps.setInt(1, id);
                    ps.executeUpdate();
                }

                // 3. Delete from sellers table
                try (PreparedStatement ps = conn.prepareStatement("DELETE FROM sellers WHERE id = ?")) {
                    ps.setInt(1, id);
                    ps.executeUpdate();
                }

                // 4. If we successfully found the userId, also delete/cascade the user records!
                if (userId > 0) {
                    // Fetch properties owned by this user
                    List<Integer> propertyIds = new ArrayList<>();
                    try (PreparedStatement ps = conn.prepareStatement("SELECT id FROM properties WHERE seller_id = ?")) {
                        ps.setInt(1, userId);
                        try (ResultSet rs = ps.executeQuery()) {
                            while (rs.next()) {
                                propertyIds.add(rs.getInt("id"));
                            }
                        }
                    }

                    // Delete dependent records for each property
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
                        ps.setInt(1, userId);
                        ps.executeUpdate();
                    }

                    // Delete inquiries created by this user
                    try (PreparedStatement ps = conn.prepareStatement("DELETE FROM inquiries WHERE buyer_id = ?")) {
                        ps.setInt(1, userId);
                        ps.executeUpdate();
                    }

                    // Delete the user from users table
                    try (PreparedStatement ps = conn.prepareStatement("DELETE FROM users WHERE id = ?")) {
                        ps.setInt(1, userId);
                        ps.executeUpdate();
                    }
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

    public boolean updateSellerProfileWithDetails(int userId, String name, String phone, String address, String bio, String licenseNumber, String agencyName, String specialization) {
        // Self-heal: If the seller row does not exist in the sellers table, create it first
        if (getByUserId(userId) == null) {
            String randomLicense = (licenseNumber != null && !licenseNumber.isBlank()) ? licenseNumber : "LIC-" + (100000 + new java.util.Random().nextInt(900000));
            // Fetch email from users table to use as mailing address
            String userEmail = "";
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement("SELECT email FROM users WHERE id = ?")) {
                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        userEmail = rs.getString("email");
                    }
                }
            } catch (SQLException e) { e.printStackTrace(); }
            String finalMailing = (address != null && !address.isBlank()) ? address : null;
            createSeller(userId, agencyName != null ? agencyName : (name + "'s Agency"), specialization != null ? specialization : "General", "junior", 0.0, randomLicense, finalMailing);
        }

        String sql = "UPDATE sellers SET seller_name = ?, contact_phone = ?, mailing_address = ?, personal_biography = ?, license_number = ?, specialization = ? WHERE seller_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, agencyName != null ? agencyName : (name + "'s Agency"));
            ps.setString(2, phone);
            ps.setString(3, address);
            ps.setString(4, bio);
            ps.setString(5, licenseNumber);
            ps.setString(6, specialization);
            ps.setInt(7, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateSellerProfile(int userId, String name, String phone, String address, String bio) {
        Seller current = getByUserId(userId);
        String lic = current != null ? current.getLicenseNumber() : "";
        String agency = current != null ? current.getAgencyName() : (name + "'s Agency");
        String spec = current != null ? current.getSpecialization() : "General";
        return updateSellerProfileWithDetails(userId, name, phone, address, bio, lic, agency, spec);
    }

    private Seller mapRow(ResultSet rs) throws SQLException {
        String tier = rs.getString("tier");
        Seller a;
        if ("junior".equalsIgnoreCase(tier)) {
            a = new com.realestate.portal.model.JuniorSeller();
        } else if ("senior".equalsIgnoreCase(tier)) {
            a = new com.realestate.portal.model.SeniorSeller();
        } else {
            a = new Seller();
            a.setTier(tier);
        }
        a.setId(rs.getInt("id"));
        a.setUserId(rs.getInt("seller_id"));
        try { a.setUserName(rs.getString("user_name")); } catch (SQLException ignored) {}
        a.setAgencyName(rs.getString("seller_name"));
        a.setSpecialization(rs.getString("specialization"));
        try { a.setRating(rs.getDouble("rating")); } catch (SQLException ignored) {}
        a.setCreatedAt(rs.getString("created_at"));
        
        // Fetch new columns
        try { a.setLicenseNumber(rs.getString("license_number")); } catch (SQLException ignored) {}
        try { a.setContactPhone(rs.getString("contact_phone")); } catch (SQLException ignored) {}
        try { a.setMailingAddress(rs.getString("mailing_address")); } catch (SQLException ignored) {}
        try { a.setPersonalBiography(rs.getString("personal_biography")); } catch (SQLException ignored) {}
        
        return a;
    }
}
