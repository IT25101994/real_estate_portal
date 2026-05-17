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

    public boolean createSeller(int userId, String agencyName, String specialization, String tier, double rating) {
        String sql = "INSERT INTO sellers (seller_id, seller_name, specialization, tier, rating) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId); ps.setString(2, agencyName);
            ps.setString(3, specialization); ps.setString(4, tier); ps.setDouble(5, rating);
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
        String sql = "DELETE FROM sellers WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    private Seller mapRow(ResultSet rs) throws SQLException {
        Seller a = new Seller();
        a.setId(rs.getInt("id"));
        a.setUserId(rs.getInt("seller_id"));
        try { a.setUserName(rs.getString("user_name")); } catch (SQLException ignored) {}
        a.setAgencyName(rs.getString("seller_name"));
        a.setSpecialization(rs.getString("specialization"));
        a.setTier(rs.getString("tier"));
        try { a.setRating(rs.getDouble("rating")); } catch (SQLException ignored) {}
        a.setCreatedAt(rs.getString("created_at"));
        return a;
    }
}
