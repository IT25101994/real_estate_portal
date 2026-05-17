package com.realestate.portal.util;

import com.realestate.portal.model.CommercialProperty;
import com.realestate.portal.model.Property;
import com.realestate.portal.model.ResidentialProperty;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

// Abstraction
public class PropertyDAO {

    // Constructor
    public PropertyDAO() {
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.execute("ALTER TABLE properties ADD COLUMN image_url VARCHAR(255)");
        } catch (SQLException ignored) {
            // Field might already exist.
        }
    }

    public int createProperty(Integer sellerId, String title, String location,
                                  double price, String type, int bedrooms,
                                  String status, String description, String imageUrl, String businessType) {
        String sql = "INSERT INTO properties "
                + "(seller_id, title, location, price, type, bedrooms, status, description, image_url, business_type) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            if (sellerId != null && sellerId > 0) {
                ps.setInt(1, sellerId);
            } else {
                ps.setNull(1, java.sql.Types.INTEGER);
            }
            ps.setString(2, title);
            ps.setString(3, location);
            ps.setDouble(4, price);
            ps.setString(5, type);
            ps.setInt(6, bedrooms);
            ps.setString(7, status);
            ps.setString(8, description);
            ps.setString(9, imageUrl);
            ps.setString(10, businessType);
            
            int affected = ps.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public void addGalleryImages(int propertyId, List<String> images) {
        if (images == null || images.isEmpty()) return;
        String sql = "INSERT INTO property_images (property_id, image_url) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            for (String img : images) {
                ps.setInt(1, propertyId);
                ps.setString(2, img);
                ps.addBatch();
            }
            ps.executeBatch();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public List<String> getGalleryImages(int propertyId) {
        List<String> list = new ArrayList<>();
        String sql = "SELECT image_url FROM property_images WHERE property_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, propertyId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(rs.getString(1));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public List<Property> getAllProperties() {
        List<Property> list = new ArrayList<>();
        String sql = "SELECT p.*, u.name AS seller_name, u.profile_photo AS seller_photo "
                + "FROM properties p "
                + "LEFT JOIN users u ON p.seller_id = u.id "
                + "ORDER BY p.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Property> search(String keyword, String type, String status) {
        List<Property> list = new ArrayList<>();

        boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
        boolean hasType    = type    != null && !type.trim().isEmpty();
        boolean hasStatus  = status  != null && !status.trim().isEmpty();

        StringBuilder sql = new StringBuilder(
                "SELECT p.*, u.name AS seller_name, u.profile_photo AS seller_photo "
                        + "FROM properties p "
                        + "LEFT JOIN users u ON p.seller_id = u.id "
                        + "WHERE 1=1");

        if (hasKeyword) sql.append(" AND (p.title LIKE ? OR p.location LIKE ?)");
        if (hasType)    sql.append(" AND p.type = ?");
        if (hasStatus)  sql.append(" AND p.status = ?");
        sql.append(" ORDER BY p.created_at DESC");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int i = 1;
            if (hasKeyword) {
                String like = "%" + keyword + "%";
                ps.setString(i++, like);
                ps.setString(i++, like);
            }
            if (hasType)   ps.setString(i++, type);
            if (hasStatus) ps.setString(i++, status);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Property getById(int id) {
        String sql = "SELECT p.*, u.name AS seller_name, u.profile_photo AS seller_photo "
                + "FROM properties p "
                + "LEFT JOIN users u ON p.seller_id = u.id "
                + "WHERE p.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Property p = mapRow(rs);
                    if (p != null) p.setGalleryImages(getGalleryImages(id));
                    return p;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateProperty(int id, String title, String location,
                                  double price, int bedrooms,
                                  String status, String description, String imageUrl, String type, String businessType) {
        String sql = "UPDATE properties "
                + "SET title=?, location=?, price=?, bedrooms=?, status=?, description=?, image_url=?, type=?, business_type=? "
                + "WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, title);
            ps.setString(2, location);
            ps.setDouble(3, price);
            ps.setInt(4, bedrooms);
            ps.setString(5, status);
            ps.setString(6, description);
            ps.setString(7, imageUrl);
            ps.setString(8, type);
            ps.setString(9, businessType);
            ps.setInt(10, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteProperty(int id) {
        String sql = "DELETE FROM properties WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Property mapRow(ResultSet rs) throws SQLException {
        // Polymorphism
        String type = rs.getString("type");

        Property p;
        if ("Commercial".equalsIgnoreCase(type)) {
            CommercialProperty cp = new CommercialProperty();
            try {
                cp.setBusinessType(rs.getString("business_type"));
            } catch (SQLException ignored) {}
            p = cp;
        } else {
            p = new ResidentialProperty();
        }

        p.setId(rs.getInt("id"));
        p.setSellerId(rs.getInt("seller_id"));
        p.setTitle(rs.getString("title"));
        p.setLocation(rs.getString("location"));
        p.setPrice(rs.getDouble("price"));
        p.setType(type);
        p.setBedrooms(rs.getInt("bedrooms"));
        p.setStatus(rs.getString("status"));
        p.setDescription(rs.getString("description"));
        p.setCreatedAt(rs.getString("created_at"));

        try {
            p.setImageUrl(rs.getString("image_url"));
        } catch (SQLException ignored) {}

        try {
            p.setSellerName(rs.getString("seller_name"));
        } catch (SQLException ignored) {}

        try {
            p.setSellerPhoto(rs.getString("seller_photo"));
        } catch (SQLException ignored) {}

        return p;
    }
}