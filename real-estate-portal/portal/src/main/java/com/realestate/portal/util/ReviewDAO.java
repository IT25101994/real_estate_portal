package com.realestate.portal.util;

import com.realestate.portal.model.Review;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * MEMBER 6 — ReviewDAO
 */
public class ReviewDAO {

    public boolean createReview(Integer userId, String reviewerName, int targetId, String targetType, int rating, String comment) {
        String sql = "INSERT INTO reviews (reviewer_id, reviewer_name, target_id, target_type, rating, comment) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (userId != null && userId > 0) {
                ps.setInt(1, userId);
            } else {
                ps.setNull(1, java.sql.Types.INTEGER);
            }
            ps.setString(2, reviewerName);
            ps.setInt(3, targetId);
            ps.setString(4, targetType);
            ps.setInt(5, rating);
            ps.setString(6, comment);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public List<Review> getAllReviews() {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT r.*, COALESCE(u.name, r.reviewer_name) AS user_name, u.profile_photo AS user_photo FROM reviews r "
                   + "LEFT JOIN users u ON r.reviewer_id = u.id ORDER BY r.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public List<Review> getByTarget(String targetType, int targetId) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT r.*, COALESCE(u.name, r.reviewer_name) AS user_name, u.profile_photo AS user_photo FROM reviews r "
                   + "LEFT JOIN users u ON r.reviewer_id = u.id "
                   + "WHERE r.target_type = ? AND r.target_id = ? ORDER BY r.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, targetType); ps.setInt(2, targetId);
            try (ResultSet rs = ps.executeQuery()) { while (rs.next()) list.add(mapRow(rs)); }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public Review getById(int id) {
        String sql = "SELECT r.*, COALESCE(u.name, r.reviewer_name) AS user_name, u.profile_photo AS user_photo FROM reviews r "
                   + "LEFT JOIN users u ON r.reviewer_id = u.id WHERE r.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) { if (rs.next()) return mapRow(rs); }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    /** Returns average rating for a property or seller. Returns 0.0 if none. */
    public double getAverageRating(String targetType, int targetId) {
        String sql = "SELECT AVG(rating) FROM reviews WHERE target_type = ? AND target_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, targetType); ps.setInt(2, targetId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getDouble(1);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return 0.0;
    }

    public boolean updateReview(int id, int rating, String comment) {
        String sql = "UPDATE reviews SET rating=?, comment=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, rating); ps.setString(2, comment); ps.setInt(3, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean deleteReview(int id) {
        String sql = "DELETE FROM reviews WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    private Review mapRow(ResultSet rs) throws SQLException {
        Review r = new Review();
        r.setId(rs.getInt("id"));
        r.setUserId(rs.getInt("reviewer_id"));
        r.setTargetId(rs.getInt("target_id"));
        r.setTargetType(rs.getString("target_type"));
        r.setRating(rs.getInt("rating"));
        r.setComment(rs.getString("comment"));
        try { r.setUserName(rs.getString("user_name")); } catch (SQLException ignored) {}
        try { r.setUserPhoto(rs.getString("user_photo")); } catch (SQLException ignored) {}
        r.setCreatedAt(rs.getString("created_at"));
        return r;
    }
}
