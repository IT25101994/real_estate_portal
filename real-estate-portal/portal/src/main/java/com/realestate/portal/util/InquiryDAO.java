package com.realestate.portal.util;

import com.realestate.portal.model.Inquiry;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * MEMBER 3 — InquiryDAO
 */
public class InquiryDAO {

    public boolean createInquiry(int buyerId, int propertyId, String message) {
        String sql = "INSERT INTO inquiries (buyer_id, property_id, message) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, buyerId); ps.setInt(2, propertyId); ps.setString(3, message);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public List<Inquiry> getAllInquiries() {
        List<Inquiry> list = new ArrayList<>();
        String sql = "SELECT i.*, u.name AS buyer_name, p.title AS property_title "
                   + "FROM inquiries i "
                   + "LEFT JOIN users u ON i.buyer_id = u.id "
                   + "LEFT JOIN properties p ON i.property_id = p.id "
                   + "ORDER BY i.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public List<Inquiry> getByBuyer(int buyerId) {
        List<Inquiry> list = new ArrayList<>();
        String sql = "SELECT i.*, u.name AS buyer_name, p.title AS property_title "
                   + "FROM inquiries i "
                   + "LEFT JOIN users u ON i.buyer_id = u.id "
                   + "LEFT JOIN properties p ON i.property_id = p.id "
                   + "WHERE i.buyer_id = ? ORDER BY i.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, buyerId);
            try (ResultSet rs = ps.executeQuery()) { while (rs.next()) list.add(mapRow(rs)); }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public Inquiry getById(int id) {
        String sql = "SELECT i.*, u.name AS buyer_name, p.title AS property_title "
                   + "FROM inquiries i "
                   + "LEFT JOIN users u ON i.buyer_id = u.id "
                   + "LEFT JOIN properties p ON i.property_id = p.id WHERE i.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) { if (rs.next()) return mapRow(rs); }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public boolean updateStatus(int id, String status, String response) {
        String sql = "UPDATE inquiries SET status = ?, response = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status); ps.setString(2, response); ps.setInt(3, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean deleteInquiry(int id) {
        String sql = "DELETE FROM inquiries WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public int[] getInquiryCountsByStatus() {
        int[] counts = new int[3]; // [Pending, Responded, Resolved]
        String sql = "SELECT status, COUNT(*) FROM inquiries GROUP BY status";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String status = rs.getString(1);
                int count = rs.getInt(2);
                if ("Pending".equalsIgnoreCase(status)) counts[0] = count;
                else if ("Responded".equalsIgnoreCase(status)) counts[1] = count;
                else if ("Resolved".equalsIgnoreCase(status)) counts[2] = count;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return counts;
    }

    private Inquiry mapRow(ResultSet rs) throws SQLException {
        Inquiry i = new Inquiry();
        i.setId(rs.getInt("id"));
        i.setBuyerId(rs.getInt("buyer_id"));
        i.setPropertyId(rs.getInt("property_id"));
        i.setMessage(rs.getString("message"));
        i.setStatus(rs.getString("status"));
        try { i.setResponse(rs.getString("response")); } catch (SQLException ignored) {}
        try { i.setBuyerName(rs.getString("buyer_name")); } catch (SQLException ignored) {}
        try { i.setPropertyTitle(rs.getString("property_title")); } catch (SQLException ignored) {}
        i.setCreatedAt(rs.getString("created_at"));
        return i;
    }
}
