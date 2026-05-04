package com.realestate.portal.servlet;

import com.realestate.portal.model.Review;
import com.realestate.portal.util.ReviewDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * MEMBER 6 — ReviewServlet
 */
@WebServlet("/reviews")
public class ReviewServlet extends HttpServlet {

    private final ReviewDAO dao = new ReviewDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list" -> {
                com.realestate.portal.model.User user = (com.realestate.portal.model.User) req.getSession().getAttribute("user");
                if (user == null || (!"ADMIN".equalsIgnoreCase(user.getType()))) {
                    resp.sendRedirect(req.getContextPath() + "/dashboard?error=access_denied");
                    return;
                }
                req.setAttribute("reviews", dao.getAllReviews());
                req.getRequestDispatcher("/WEB-INF/views/review-list.jsp").forward(req, resp);
            }
            case "submit" -> {
                if (req.getSession().getAttribute("user") == null && req.getSession().getAttribute("admin") == null) {
                    resp.sendRedirect(req.getContextPath() + "/login?error=Please login to submit reviews");
                    return;
                }
                String targetType = req.getParameter("targetType");
                if (targetType != null) targetType = targetType.toLowerCase();
                req.setAttribute("targetType", targetType);
                req.setAttribute("targetId",   req.getParameter("targetId"));
                req.getRequestDispatcher("/WEB-INF/views/submit-review.jsp").forward(req, resp);
            }
            case "view" -> {
                String targetType = req.getParameter("targetType");
                if (targetType != null) targetType = targetType.toLowerCase();
                int    targetId   = Integer.parseInt(req.getParameter("targetId"));
                req.setAttribute("reviews",       dao.getByTarget(targetType, targetId));
                req.setAttribute("averageRating", dao.getAverageRating(targetType, targetId));
                req.setAttribute("targetType",    targetType);
                req.setAttribute("targetId",      targetId);
                req.getRequestDispatcher("/WEB-INF/views/view-reviews.jsp").forward(req, resp);
            }
            case "edit" -> {
                com.realestate.portal.model.User user = (com.realestate.portal.model.User) req.getSession().getAttribute("user");
                if (user == null || (!"ADMIN".equalsIgnoreCase(user.getType()))) {
                    resp.sendRedirect(req.getContextPath() + "/dashboard?error=access_denied");
                    return;
                }
                int id = Integer.parseInt(req.getParameter("id"));
                Review r = dao.getById(id);
                req.setAttribute("review", r);
                req.setAttribute("targetType", r.getTargetType());
                req.setAttribute("targetId",   r.getTargetId());
                req.getRequestDispatcher("/WEB-INF/views/submit-review.jsp").forward(req, resp);
            }
            case "delete" -> {
                com.realestate.portal.model.User user = (com.realestate.portal.model.User) req.getSession().getAttribute("user");
                if (user == null || (!"ADMIN".equalsIgnoreCase(user.getType()))) {
                    resp.sendRedirect(req.getContextPath() + "/dashboard?error=access_denied");
                    return;
                }
                int id = Integer.parseInt(req.getParameter("id"));
                dao.deleteReview(id);
                resp.sendRedirect(req.getContextPath() + "/reviews?action=list&msg=deleted");
            }
            default -> resp.sendRedirect(req.getContextPath() + "/reviews?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("submit".equals(action)) {
            String targetType = req.getParameter("targetType");
            if (targetType != null) targetType = targetType.toLowerCase();
            
            com.realestate.portal.model.User user = (com.realestate.portal.model.User) req.getSession().getAttribute("user");
            Integer reviewerId = null;
            String reviewerName = "Anonymous";
            
            if (user != null) {
                reviewerName = user.getName();
                // Only use ID as FK if they are NOT an admin
                if (!"ADMIN".equalsIgnoreCase(user.getType())) {
                    reviewerId = user.getId();
                }
            }

            boolean success = dao.createReview(
                reviewerId,
                reviewerName,
                Integer.parseInt(req.getParameter("targetId")),
                targetType,
                Integer.parseInt(req.getParameter("rating")),
                req.getParameter("comment"));
            
            if (success) {
                // If it was an admin, they might want to go to the list, 
                // but usually they are reviewing too. Best to go to view.
                resp.sendRedirect(req.getContextPath() + "/reviews?action=view&targetType=" + targetType + "&targetId=" + req.getParameter("targetId") + "&msg=submitted");
            } else {
                resp.sendRedirect(req.getContextPath() + "/reviews?action=submit&msg=error&error=Could not save review. Check IDs.");
            }

        } else if ("update".equals(action)) {
            com.realestate.portal.model.User user = (com.realestate.portal.model.User) req.getSession().getAttribute("user");
            if (user == null || (!"ADMIN".equalsIgnoreCase(user.getType()))) {
                resp.sendRedirect(req.getContextPath() + "/dashboard?error=access_denied");
                return;
            }
            dao.updateReview(
                Integer.parseInt(req.getParameter("id")),
                Integer.parseInt(req.getParameter("rating")),
                req.getParameter("comment"));
            resp.sendRedirect(req.getContextPath() + "/reviews?action=list&msg=updated");
        } else if ("delete".equals(action)) {
            com.realestate.portal.model.User user = (com.realestate.portal.model.User) req.getSession().getAttribute("user");
            if (user == null || (!"ADMIN".equalsIgnoreCase(user.getType()))) {
                resp.sendRedirect(req.getContextPath() + "/dashboard?error=access_denied");
                return;
            }
            dao.deleteReview(Integer.parseInt(req.getParameter("id")));
            resp.sendRedirect(req.getContextPath() + "/reviews?action=list&msg=deleted");
        }
    }
}
