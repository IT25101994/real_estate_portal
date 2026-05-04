package com.realestate.portal.servlet;

import com.realestate.portal.util.SellerDAO;
import com.realestate.portal.util.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * MEMBER 5 — SellerServlet
 */
@WebServlet("/sellers")
public class SellerServlet extends HttpServlet {

    private final SellerDAO dao = new SellerDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list" -> {
                String kw = req.getParameter("keyword");
                req.setAttribute("sellers", kw != null && !kw.isBlank()
                        ? dao.searchSellers(kw) : dao.getAllSellers());
                req.setAttribute("keyword", kw);
                req.getRequestDispatcher("/WEB-INF/views/seller-directory.jsp").forward(req, resp);
            }
            case "register" -> {
                req.setAttribute("candidateUsers", userDAO.getUsersByType("SELLER"));
                req.getRequestDispatcher("/WEB-INF/views/seller-register.jsp").forward(req, resp);
            }
            case "edit" -> {
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("seller", dao.getById(id));
                req.getRequestDispatcher("/WEB-INF/views/edit-seller.jsp").forward(req, resp);
            }
            case "delete" -> {
                int id = Integer.parseInt(req.getParameter("id"));
                dao.deleteSeller(id);
                resp.sendRedirect(req.getContextPath() + "/sellers?action=list&msg=deleted");
            }
            default -> resp.sendRedirect(req.getContextPath() + "/sellers?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("register".equals(action)) {
            dao.createSeller(
                Integer.parseInt(req.getParameter("userId")),
                req.getParameter("agencyName"), req.getParameter("specialization"),
                req.getParameter("tier"),
                Double.parseDouble(req.getParameter("rating") == null ? "0" : req.getParameter("rating")));
            resp.sendRedirect(req.getContextPath() + "/sellers?action=list&msg=registered");

        } else if ("update".equals(action)) {
            dao.updateSeller(Integer.parseInt(req.getParameter("id")),
                            req.getParameter("agencyName"), req.getParameter("specialization"),
                            req.getParameter("tier"));
            resp.sendRedirect(req.getContextPath() + "/sellers?action=list&msg=updated");
        }
    }
}
