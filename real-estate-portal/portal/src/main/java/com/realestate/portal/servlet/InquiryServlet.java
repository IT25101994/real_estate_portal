package com.realestate.portal.servlet;

import com.realestate.portal.util.InquiryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * MEMBER 3 — InquiryServlet
 */
@WebServlet("/inquiries")
public class InquiryServlet extends HttpServlet {

    private final InquiryDAO dao = new InquiryDAO();
    private final com.realestate.portal.util.UserDAO userDAO = new com.realestate.portal.util.UserDAO();
    private final com.realestate.portal.util.PropertyDAO propertyDAO = new com.realestate.portal.util.PropertyDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list" -> {
                req.setAttribute("inquiries", dao.getAllInquiries());
                req.getRequestDispatcher("/WEB-INF/views/inquiry-list.jsp").forward(req, resp);
            }
            case "send" -> {
                req.setAttribute("users", userDAO.getAllUsers());
                req.setAttribute("properties", propertyDAO.getAllProperties());
                req.getRequestDispatcher("/WEB-INF/views/send-inquiry.jsp").forward(req, resp);
            }
            case "respond" -> {
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("inquiry", dao.getById(id));
                req.getRequestDispatcher("/WEB-INF/views/respond-inquiry.jsp").forward(req, resp);
            }
            default -> resp.sendRedirect(req.getContextPath() + "/inquiries?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("send".equals(action)) {
            dao.createInquiry(
                Integer.parseInt(req.getParameter("buyerId")),
                Integer.parseInt(req.getParameter("propertyId")),
                req.getParameter("message"));
            resp.sendRedirect(req.getContextPath() + "/inquiries?action=list&msg=sent");

        } else if ("respond".equals(action)) {
            dao.updateStatus(
                Integer.parseInt(req.getParameter("id")),
                req.getParameter("status"),
                req.getParameter("response"));
            resp.sendRedirect(req.getContextPath() + "/inquiries?action=list&msg=responded");
        } else if ("delete".equals(action)) {
            dao.deleteInquiry(Integer.parseInt(req.getParameter("id")));
            resp.sendRedirect(req.getContextPath() + "/inquiries?action=list&msg=deleted");
        }
    }
}
