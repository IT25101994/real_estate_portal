package com.realestate.portal.servlet;

import com.realestate.portal.util.AdminDAO;
import com.realestate.portal.util.InquiryDAO;
import com.realestate.portal.util.PropertyDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

@WebServlet("/admins")
public class AdminServlet extends HttpServlet {

    private final AdminDAO dao = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        com.realestate.portal.model.Admin loggedInAdmin = (com.realestate.portal.model.Admin) req.getSession().getAttribute("admin");
        if (loggedInAdmin == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) action = "dashboard";

        // Only super admin can manage admins (actions: register, edit, delete)
        if (("register".equals(action) || "edit".equals(action) || "delete".equals(action)) 
                && !loggedInAdmin.isCanManageAdmins()) {
            resp.sendRedirect(req.getContextPath() + "/admins?action=dashboard&error=unauthorized");
            return;
        }

        switch (action) {
            case "dashboard" -> {
                req.setAttribute("userCount",     dao.countTable("users"));
                req.setAttribute("propertyCount", dao.countTable("properties"));
                req.setAttribute("inquiryCount",  dao.countTable("inquiries"));
                req.setAttribute("reviewCount",   dao.countTable("reviews"));
                req.setAttribute("sellerCount",    dao.countTable("sellers"));
                
                PropertyDAO propDao = new PropertyDAO();
                req.setAttribute("recentProperties", propDao.getAllProperties());
                req.setAttribute("recentAdmins", dao.getAllAdmins());
                
                InquiryDAO inqDao = new InquiryDAO();
                req.setAttribute("inquiryStats", inqDao.getInquiryCountsByStatus());

                // Calculate real property growth data based on last 30 days (10 buckets of 3 days)
                int[] growth = new int[10];
                List<com.realestate.portal.model.Property> allProps = propDao.getAllProperties();
                LocalDateTime now = LocalDateTime.now();
                
                for (int i = 0; i < 10; i++) {
                    int daysAgo = (9 - i) * 3; 
                    LocalDateTime bucketTime = now.minusDays(daysAgo);
                    
                    int countUpToBucket = 0;
                    for (com.realestate.portal.model.Property p : allProps) {
                        if (p.getCreatedAt() != null) {
                            try {
                                String isoDate = p.getCreatedAt().replace(" ", "T");
                                if (isoDate.length() > 19) isoDate = isoDate.substring(0, 19);
                                LocalDateTime pDate = LocalDateTime.parse(isoDate);
                                
                                if (!pDate.isAfter(bucketTime)) {
                                    countUpToBucket++;
                                }
                            } catch (Exception e) {
                                countUpToBucket++; // Fallback if timestamp invalid
                            }
                        } else {
                           countUpToBucket++;
                        }
                    }
                    growth[i] = countUpToBucket;
                }
                
                req.setAttribute("propertyGrowthData", Arrays.toString(growth));
                
                req.getRequestDispatcher("/WEB-INF/views/admin-dashboard.jsp").forward(req, resp);
            }
            case "list" -> {
                req.setAttribute("admins", dao.getAllAdmins());
                req.getRequestDispatcher("/WEB-INF/views/admin-list.jsp").forward(req, resp);
            }
            case "register" ->
                req.getRequestDispatcher("/WEB-INF/views/admin-register.jsp").forward(req, resp);
            case "edit" -> {
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("admin", dao.getById(id));
                req.getRequestDispatcher("/WEB-INF/views/admin-register.jsp").forward(req, resp);
            }
            case "delete" -> {
                int id = Integer.parseInt(req.getParameter("id"));
                dao.deleteAdmin(id);
                resp.sendRedirect(req.getContextPath() + "/admins?action=list&msg=deleted");
            }
            default -> resp.sendRedirect(req.getContextPath() + "/admins?action=dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        com.realestate.portal.model.Admin loggedInAdmin = (com.realestate.portal.model.Admin) req.getSession().getAttribute("admin");
        if (loggedInAdmin == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Only super admin can manage admins
        if (!loggedInAdmin.isCanManageAdmins()) {
            resp.sendRedirect(req.getContextPath() + "/admins?action=dashboard&error=unauthorized");
            return;
        }

        String action = req.getParameter("action");

        if ("register".equals(action)) {
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String role = req.getParameter("role");

            // Verify email uniqueness before calling create
            if (dao.findByEmail(email) != null) {
                resp.sendRedirect(req.getContextPath() + "/admins?action=register&error=duplicate_email&name=" 
                        + java.net.URLEncoder.encode(name, "UTF-8") + "&role=" + role);
                return;
            }

            boolean success = dao.createAdmin(name, email, password, role);
            if (success) {
                resp.sendRedirect(req.getContextPath() + "/admins?action=list&msg=created");
            } else {
                resp.sendRedirect(req.getContextPath() + "/admins?action=register&error=db_error");
            }

        } else if ("update".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String role = req.getParameter("role");

            // Verify email uniqueness for editing admins
            com.realestate.portal.model.Admin existing = dao.findByEmail(email);
            if (existing != null && existing.getId() != id) {
                resp.sendRedirect(req.getContextPath() + "/admins?action=edit&id=" + id + "&error=duplicate_email");
                return;
            }

            boolean success = dao.updateAdmin(id, name, email, role);
            if (success) {
                resp.sendRedirect(req.getContextPath() + "/admins?action=list&msg=updated");
            } else {
                resp.sendRedirect(req.getContextPath() + "/admins?action=edit&id=" + id + "&error=db_error");
            }

        } else if ("delete".equals(action)) {
            dao.deleteAdmin(Integer.parseInt(req.getParameter("id")));
            resp.sendRedirect(req.getContextPath() + "/admins?action=list&msg=deleted");
        }
    }
}
