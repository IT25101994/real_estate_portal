package com.realestate.portal.servlet;

import com.realestate.portal.util.PropertyDAO;
import com.realestate.portal.model.Property;
import com.realestate.portal.model.User;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 20,       // 20MB per file
    maxRequestSize = 1024 * 1024 * 100    // 100MB per request
)
public class PropertyServlet extends HttpServlet {

    private final PropertyDAO dao = new PropertyDAO();

    private String saveImage(HttpServletRequest req, String fieldName) throws Exception {
        try {
            Part part = req.getPart(fieldName);
            if (part != null && part.getSize() > 0) {
                String uploadPath = req.getServletContext().getRealPath("") + File.separator + "assets" + File.separator + "images";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                String fileName = java.util.UUID.randomUUID().toString() + "_" + part.getSubmittedFileName().replaceAll("[^a-zA-Z0-9\\.\\-]", "_");
                part.write(uploadPath + File.separator + fileName);
                return "assets/images/" + fileName;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    private java.util.List<String> saveGallery(HttpServletRequest req) throws Exception {
        java.util.List<String> list = new java.util.ArrayList<>();
        try {
            java.util.Collection<Part> parts = req.getParts();
            String uploadPath = req.getServletContext().getRealPath("") + File.separator + "assets" + File.separator + "images";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            for (Part part : parts) {
                if ("gallery".equals(part.getName()) && part.getSize() > 0) {
                    String fileName = java.util.UUID.randomUUID().toString() + "_" + part.getSubmittedFileName().replaceAll("[^a-zA-Z0-9\\.\\-]", "_");
                    part.write(uploadPath + File.separator + fileName);
                    list.add("assets/images/" + fileName);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {

                case "search": {
                    String kw       = req.getParameter("keyword");
                    String location = req.getParameter("location"); // From new snippet
                    String type     = req.getParameter("type");     // 'house', 'apartment', etc from snippet
                    String status   = req.getParameter("status");
                    
                    // If 'location' select was used instead of 'keyword' text input
                    if ((kw == null || kw.isEmpty()) && location != null) {
                        kw = location;
                    }

                    // Pass to DAO. Note: If your DB 'type' column is just 'Residential',
                    // searching for 'house' might need mapping. 
                    // I will pass them as is for maximum flexibility for the user's data.
                    req.setAttribute("properties", dao.search(kw, type, status));
                    req.getRequestDispatcher("/WEB-INF/views/property-list.jsp")
                            .forward(req, resp);
                    break;
                }

                case "addForm": {
                    if (req.getSession().getAttribute("user") == null) {
                        resp.sendRedirect(req.getContextPath() + "/?error=session_expired");
                        return;
                    }
                    req.getRequestDispatcher("/WEB-INF/views/add-property.jsp")
                            .forward(req, resp);
                    break;
                }

                case "edit": {
                    if (req.getSession().getAttribute("user") == null) {
                        resp.sendRedirect(req.getContextPath() + "/?error=session_expired");
                        return;
                    }
                    int id = Integer.parseInt(req.getParameter("id"));
                    Property property = dao.getById(id);
                    req.setAttribute("property", property);
                    req.getRequestDispatcher("/WEB-INF/views/edit-property.jsp").forward(req, resp);
                    break;
                }

                case "detail": {
                    int id = Integer.parseInt(req.getParameter("id"));
                    Property property = dao.getById(id);
                    req.setAttribute("property", property);
                    req.getRequestDispatcher("/WEB-INF/views/property-detail.jsp").forward(req, resp);
                    break;
                }

                case "list":
                default: {
                    req.setAttribute("properties", dao.getAllProperties());
                    req.getRequestDispatcher("/WEB-INF/views/property-list.jsp").forward(req, resp);
                    break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/properties?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String action = req.getParameter("action");

        try {
            User user = (User) req.getSession().getAttribute("user");
            
            if (user == null) {
                resp.sendRedirect(req.getContextPath() + "/?error=session_expired");
                return;
            }

            if ("add".equals(action)) {
                String imageUrl = saveImage(req, "image"); // "image" is the cover field
                java.util.List<String> gallery = saveGallery(req);

                Integer sellerId = "ADMIN".equalsIgnoreCase(user.getType()) ? null : user.getId();
                if (req.getParameter("price") == null || req.getParameter("bedrooms") == null) {
                    resp.sendRedirect(req.getContextPath() + "/properties?action=list&error=invalid_parameters");
                    return;
                }

                int propertyId = dao.createProperty(
                        sellerId,
                        req.getParameter("title"),
                        req.getParameter("location"),
                        Double.parseDouble(req.getParameter("price")),
                        req.getParameter("type"),
                        Integer.parseInt(req.getParameter("bedrooms")),
                        req.getParameter("status"),
                        req.getParameter("description"),
                        imageUrl,
                        req.getParameter("businessType")
                );
                
                if (propertyId > 0) {
                    dao.addGalleryImages(propertyId, gallery);
                    resp.sendRedirect(req.getContextPath() + "/properties?action=list&msg=added");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/properties?action=list&error=db_insert_failed");
                }

            } else if ("update".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                String imageUrl = saveImage(req, "image");
                if (imageUrl == null) {
                    Property existing = dao.getById(id);
                    if (existing != null) {
                        imageUrl = existing.getImageUrl();
                    }
                }
                
                dao.updateProperty(
                        id,
                        req.getParameter("title"),
                        req.getParameter("location"),
                        Double.parseDouble(req.getParameter("price")),
                        Integer.parseInt(req.getParameter("bedrooms")),
                        req.getParameter("status"),
                        req.getParameter("description"),
                        imageUrl,
                        req.getParameter("type"),
                        req.getParameter("businessType")
                );
                resp.sendRedirect(req.getContextPath()
                        + "/properties?action=list&msg=updated");

            } else if ("delete".equals(action)) {
                dao.deleteProperty(Integer.parseInt(req.getParameter("id")));
                resp.sendRedirect(req.getContextPath()
                        + "/properties?action=list&msg=deleted");
            }

        } catch (Exception e) {
            System.err.println("PropertyServlet Error: " + e.getMessage());
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/properties?action=list&error=server_crash_" + e.getClass().getSimpleName());
        }
    }
}
