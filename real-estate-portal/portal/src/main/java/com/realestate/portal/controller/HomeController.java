package com.realestate.portal.controller;

// Import User model class
import com.realestate.portal.model.User;

// Import class for user database operations
import com.realestate.portal.util.UserDAO;

// Import class for property database operations
import com.realestate.portal.util.PropertyDAO;

//Marks class as a web controller and Handles web requessts and send pagess(JSP/HTML) back to the user
import org.springframework.stereotype.Controller;

//send data from java to HTMl/JSP page
import org.springframework.ui.Model;

//maps HTTP GET(read) requests
import org.springframework.web.bind.annotation.GetMapping;

//maps HTTP POST(send) requests
import org.springframework.web.bind.annotation.PostMapping;

//Get values from form or URL.Take input from user request
import org.springframework.web.bind.annotation.RequestParam;

//Returns data directly instead of a webpage.
import org.springframework.web.bind.annotation.ResponseBody;

//used to manage user session data in a web application
import jakarta.servlet.http.HttpSession;

//tells Spring this class handles web pages/requests
@Controller
public class HomeController {

    //handle user database operations in the class
    private final UserDAO userDAO = new UserDAO();
    //handle property database operations in the class
    private final PropertyDAO propertyDAO = new PropertyDAO();

    @GetMapping("/")
    public String welcome(HttpSession session) {
        return "welcome";
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/";
        }
        model.addAttribute("properties", propertyDAO.getAllProperties());
        return "home";  // maps to /WEB-INF/views/home.jsp
    }

    @GetMapping("/login")
    public String loginPage(HttpSession session) {
        if (session.getAttribute("user") != null) {
            return "redirect:/dashboard";
        }
        return "welcome";
    }

    @GetMapping("/register")
    public String registerPage(HttpSession session) {
        if (session.getAttribute("user") != null) {
            return "redirect:/dashboard";
        }
        return "welcome";
    }

    @PostMapping("/login")
    public String login(@RequestParam("role") String role, @RequestParam("email") String email, @RequestParam("password") String password, HttpSession session, Model model) {
        if ("ADMIN".equalsIgnoreCase(role)) {
            com.realestate.portal.util.AdminDAO adminDAO = new com.realestate.portal.util.AdminDAO();
            com.realestate.portal.model.Admin admin = adminDAO.findByEmail(email);
            if (admin != null && admin.getPassword().equals(password)) {
                session.setAttribute("admin", admin);
                // Also create a "user" object so existing session checks and shared fields work
                User user = new User();
                user.setId(admin.getId());
                user.setName(admin.getName());
                user.setEmail(admin.getEmail());
                user.setType("ADMIN");
                session.setAttribute("user", user);
                return "redirect:/dashboard";
            }
        } else {
            User user = userDAO.findByEmail(email);
            if (user != null && user.getPassword().equals(password)) {
                if (!user.getType().equalsIgnoreCase(role)) {
                    model.addAttribute("error", "Access Denied: You are not registered as " + role + ". Your actual role is " + user.getType() + ".");
                    return "welcome";
                }
                session.setAttribute("user", user);
                return "redirect:/dashboard";
            }
        }
        model.addAttribute("error", "Invalid email or password");
        return "welcome";
    }

    @PostMapping("/oauth-login")
    public String oauthLogin(@RequestParam("email") String email, @RequestParam("name") String name, HttpSession session) {
        User user = userDAO.findByEmail(email);
        if (user == null) {
            // Create a new user automatically for social logins
            userDAO.createUser(name, email, "OAUTH_USER_NO_PASSWORD", "BUYER");
            user = userDAO.findByEmail(email);
        }
        session.setAttribute("user", user);
        return "redirect:/dashboard";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    @GetMapping("/test")
    @ResponseBody
    public String test() {
        return "Controller is working!";
    }

    @GetMapping("/market-trends")
    public String marketTrends(HttpSession session) {
        return "market-trends";
    }

    @GetMapping("/privacy-policy")
    public String privacyPolicy(HttpSession session) {
        return "privacy-policy";
    }

    @GetMapping("/terms-of-service")
    public String termsOfService(HttpSession session) {
        return "terms-of-service";
    }

    @GetMapping("/support-center")
    public String supportCenter(HttpSession session) {
        return "support-center";
    }

    @GetMapping("/contact-us")
    public String contactUs(HttpSession session) {
        return "contact-us";
    }
}