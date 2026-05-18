package com.realestate.portal.controller;

import com.realestate.portal.model.User;
import com.realestate.portal.util.UserDAO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/profile")
public class ProfileController {

    private final UserDAO userDAO = new UserDAO();

    @GetMapping
    public String viewProfile(HttpSession session, Model model, @RequestParam(value = "msg", required = false) String msg) {
        User loggedInUser = (User) session.getAttribute("user");
        if (loggedInUser == null) {
            return "redirect:/login";
        }
        
        // Refresh user from DB to get the latest profile details
        User refreshedUser = null;
        if ("ADMIN".equalsIgnoreCase(loggedInUser.getType()) || "admin".equalsIgnoreCase(loggedInUser.getType())) {
            com.realestate.portal.util.AdminDAO adminDAO = new com.realestate.portal.util.AdminDAO();
            com.realestate.portal.model.Admin admin = adminDAO.getById(loggedInUser.getId());
            if (admin != null) {
                refreshedUser = new User();
                refreshedUser.setId(admin.getId());
                refreshedUser.setName(admin.getName());
                refreshedUser.setEmail(admin.getEmail());
                refreshedUser.setType("ADMIN");
                refreshedUser.setCreatedAt(admin.getCreatedAt());
                refreshedUser.setProfilePhoto(admin.getProfilePhoto());
            }
        } else {
            refreshedUser = userDAO.getUserById(loggedInUser.getId());
        }

        if (refreshedUser != null) {
            session.setAttribute("user", refreshedUser);
            model.addAttribute("userProfile", refreshedUser);
        }
        model.addAttribute("msg", msg);
        
        return "profile"; // points to profile.jsp
    }

    @PostMapping("/update")
    public String updateProfile(
            @RequestParam("id") int id,
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam(value = "password", required = false) String password,
            @RequestParam(value = "phone", required = false) String phone,
            @RequestParam(value = "address", required = false) String address,
            @RequestParam(value = "bio", required = false) String bio,
            HttpSession session) {

        User loggedInUser = (User) session.getAttribute("user");
        if (loggedInUser == null || loggedInUser.getId() != id) {
            return "redirect:/login";
        }

        if ("ADMIN".equalsIgnoreCase(loggedInUser.getType()) || "admin".equalsIgnoreCase(loggedInUser.getType())) {
            com.realestate.portal.util.AdminDAO adminDAO = new com.realestate.portal.util.AdminDAO();
            com.realestate.portal.model.Admin loggedInAdmin = (com.realestate.portal.model.Admin) session.getAttribute("admin");
            String role = (loggedInAdmin != null) ? loggedInAdmin.getRole() : "moderator";
            adminDAO.updateAdmin(id, name, email, role);
            
            // Refresh session attributes to reflect the updated details instantly
            com.realestate.portal.model.Admin updatedAdmin = adminDAO.getById(id);
            if (updatedAdmin != null) {
                session.setAttribute("admin", updatedAdmin);
                User user = new User();
                user.setId(updatedAdmin.getId());
                user.setName(updatedAdmin.getName());
                user.setEmail(updatedAdmin.getEmail());
                user.setType("ADMIN");
                session.setAttribute("user", user);
            }
        } else {
            userDAO.updateUser(id, name, email, password, loggedInUser.getType());
            userDAO.updateProfileDetails(id, phone, address, bio);
        }
        
        return "redirect:/profile?msg=updated";
    }

    @PostMapping("/upload-photo")
    public String uploadPhoto(@RequestParam("photo") org.springframework.web.multipart.MultipartFile file, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("user");
        if (loggedInUser == null || file.isEmpty()) {
            return "redirect:/profile";
        }

        try {
            String fileName = "profile_" + loggedInUser.getId() + "_" + System.currentTimeMillis() + "_" + file.getOriginalFilename();
            String uploadDir = session.getServletContext().getRealPath("/") + "uploads/profiles/";
            java.io.File dir = new java.io.File(uploadDir);
            if (!dir.exists()) dir.mkdirs();

            java.io.File dest = new java.io.File(uploadDir + fileName);
            file.transferTo(dest);

            String dbPath = "uploads/profiles/" + fileName;
            
            if ("ADMIN".equalsIgnoreCase(loggedInUser.getType()) || "admin".equalsIgnoreCase(loggedInUser.getType())) {
                com.realestate.portal.util.AdminDAO adminDAO = new com.realestate.portal.util.AdminDAO();
                adminDAO.updateProfilePhoto(loggedInUser.getId(), dbPath);
            } else {
                userDAO.updateProfilePhoto(loggedInUser.getId(), dbPath);
            }

            return "redirect:/profile?msg=updated";
        } catch (java.io.IOException e) {
            e.printStackTrace();
            return "redirect:/profile?error=upload_failed";
        }
    }
}
