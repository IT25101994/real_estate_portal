package com.realestate.portal.controller;

import com.realestate.portal.model.User;
import com.realestate.portal.util.UserDAO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/users")
public class UserPageController {

    private final UserDAO userDAO = new UserDAO();

    // ── GET ────────────────────────────────────────────────────────────────
    @GetMapping
    public String listUsers(
            @RequestParam(value = "action", required = false) String action,
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "id", required = false) Integer id,
            @RequestParam(value = "msg", required = false) String msg,
            Model model) {

        if ("registerForm".equals(action)) {
            return "register";
        }

        if ("edit".equals(action) && id != null) {
            User user = userDAO.getUserById(id);
            model.addAttribute("user", user);
            return "edit-user";
        }

        if ("search".equals(action) && keyword != null && !keyword.isBlank()) {
            model.addAttribute("users", userDAO.searchUsers(keyword));
        } else {
            model.addAttribute("users", userDAO.getAllUsers());
        }

        model.addAttribute("msg", msg);
        return "user-list";
    }

    // ── POST ───────────────────────────────────────────────────────────────
    @PostMapping
    public String handlePost(
            @RequestParam(value = "action") String action,
            @RequestParam(value = "id", required = false) Integer id,
            @RequestParam(value = "name", required = false) String name,
            @RequestParam(value = "email", required = false) String email,
            @RequestParam(value = "password", required = false) String password,
            @RequestParam(value = "type", required = false) String type) {

        switch (action) {
            case "update":
                // ✅ now passes password and type too
                userDAO.updateUser(id, name, email, password, type);
                return "redirect:/users?msg=updated";

            case "delete":
                userDAO.deleteUser(id);
                return "redirect:/users?msg=deleted";

            default:
                return "redirect:/users";
        }
    }

    // ── POST: Register ─────────────────────────────────────────────────────
    @PostMapping("/register")
    public String createUser(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            @RequestParam("type") String type,
            jakarta.servlet.http.HttpSession session) {

        boolean success = userDAO.createUser(name, email, password, type);
        
        if (success) {
            // Check if it's a public registration (no one logged in) or an admin creating a user
            if (session.getAttribute("user") == null) {
                // Public registration: Show success message and require manual login
                return "redirect:/login?msg=registered";
            } else {
                // An admin creating another user from the dashboard
                return "redirect:/users?msg=registered";
            }
        } else {
             return session.getAttribute("user") == null 
                ? "redirect:/users?action=registerForm&msg=error" 
                : "redirect:/users?msg=error";
        }
    }
}