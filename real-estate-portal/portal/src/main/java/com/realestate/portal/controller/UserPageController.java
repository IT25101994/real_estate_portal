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

    @GetMapping
    public String listUsers(
            @RequestParam(value = "action", required = false) String action,
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "id", required = false) Integer id,
            @RequestParam(value = "msg", required = false) String msg,
            jakarta.servlet.http.HttpSession session,
            Model model) {

        com.realestate.portal.model.Admin loggedInAdmin = (com.realestate.portal.model.Admin) session.getAttribute("admin");
        if (loggedInAdmin == null) {
            return "redirect:/login";
        }

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

    @PostMapping
    public String handlePost(
            @RequestParam(value = "action") String action,
            @RequestParam(value = "id", required = false) Integer id,
            @RequestParam(value = "name", required = false) String name,
            @RequestParam(value = "email", required = false) String email,
            @RequestParam(value = "password", required = false) String password,
            @RequestParam(value = "type", required = false) String type,
            jakarta.servlet.http.HttpSession session) {

        com.realestate.portal.model.Admin loggedInAdmin = (com.realestate.portal.model.Admin) session.getAttribute("admin");
        if (loggedInAdmin == null) {
            return "redirect:/login";
        }

        switch (action) {
            case "update":
                userDAO.updateUser(id, name, email, password, type);
                return "redirect:/users?msg=updated";

            case "delete":
                if (!loggedInAdmin.isCanDeleteUsers()) {
                    return "redirect:/users?msg=error_unauthorized";
                }
                userDAO.deleteUser(id);
                return "redirect:/users?msg=deleted";

            default:
                return "redirect:/users";
        }
    }

    @PostMapping("/register")
    public String createUser(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            @RequestParam("type") String type,
            jakarta.servlet.http.HttpSession session) {

        User loggedInUser = (User) session.getAttribute("user");
        com.realestate.portal.model.Admin loggedInAdmin = (com.realestate.portal.model.Admin) session.getAttribute("admin");

        if (loggedInAdmin == null && loggedInUser == null) {
            // Guest registering from the welcome page
            if (!"BUYER".equalsIgnoreCase(type) && !"SELLER".equalsIgnoreCase(type)) {
                return "redirect:/register?error=invalid_role";
            }
        } else if (loggedInAdmin == null) {
            // Logged in non-admin trying to post register requests
            return "redirect:/dashboard";
        }

        boolean success = userDAO.createUser(name, email, password, type);
        
        if (success) {
            if (session.getAttribute("user") == null && session.getAttribute("admin") == null) {
                return "redirect:/login?msg=registered";
            } else {
                return "redirect:/users?msg=registered";
            }
        } else {
             return (session.getAttribute("user") == null && session.getAttribute("admin") == null)
                ? "redirect:/users?action=registerForm&msg=error" 
                : "redirect:/users?msg=error";
        }
    }
}