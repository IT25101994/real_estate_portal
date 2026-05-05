<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Property Hub | Access Portal</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Marcellus&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        :root {
            --emerald: #00a884;
            --dark-navy: #0a1128;
            --gold: #c5a059;
            --white: #ffffff;
            --light-bg: #f7f8fa;
            --border: #e8eaed;
            --text-muted: #9aa0ab;
            --transition: all 0.55s cubic-bezier(0.22, 1, 0.36, 1);
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body, html {
            height: 100%;
            font-family: 'Plus Jakarta Sans', sans-serif;
            overflow: hidden;
            background: var(--dark-navy);
        }

        /* =========================================
           FULL-BLEED BACKGROUND IMAGE
        ========================================= */
        .portal-bg {
            position: fixed;
            inset: 0;
            background-image: url('https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=2070');
            background-size: cover;
            background-position: center;
            transition: var(--transition);
            z-index: 0;
        }
        .portal-bg.reg-mode {
            background-image: url('https://images.unsplash.com/photo-1512917774080-9991f1c4c750?q=80&w=2070');
        }
        .portal-bg::after {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(to right, rgba(10,17,40,0.45) 40%, rgba(10,17,40,0.15) 100%);
        }

        /* =========================================
           LAYOUT WRAPPER
        ========================================= */
        .portal-wrapper {
            position: relative;
            z-index: 1;
            display: flex;
            height: 100vh;
            width: 100vw;
            align-items: stretch;
        }

        /* =========================================
           LEFT BRAND PANEL
        ========================================= */
        .brand-panel {
            flex: 1.3;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            padding: 60px 64px;
            color: white;
        }

        .brand-logo {
            display: flex;
            align-items: center;
            gap: 10px;
            position: absolute;
            top: 36px;
            left: 48px;
        }

        .brand-logo .logo-icon {
            width: 36px; height: 36px;
            background: var(--emerald);
            border-radius: 8px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1rem;
            color: white;
        }

        .brand-logo span {
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-weight: 600;
            font-size: 1.05rem;
            color: white;
            letter-spacing: 0.2px;
        }

        .brand-title {
            font-family: 'Marcellus', serif;
            font-size: clamp(2.8rem, 5vw, 4.8rem);
            line-height: 1.05;
            letter-spacing: -0.5px;
            text-shadow: 0 4px 30px rgba(0,0,0,0.3);
            margin-bottom: 14px;
        }

        .brand-subtitle {
            font-size: 0.78rem;
            font-weight: 600;
            letter-spacing: 5px;
            text-transform: uppercase;
            color: rgba(255,255,255,0.75);
            margin-bottom: 8px;
        }

        .brand-location {
            font-size: 1rem;
            font-weight: 400;
            color: rgba(255,255,255,0.7);
        }

        /* =========================================
           RIGHT FORM PANEL
        ========================================= */
        .form-panel {
            width: 420px;
            min-width: 380px;
            background: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            overflow-y: auto;
            padding: 48px 40px;
            box-shadow: -20px 0 60px rgba(0,0,0,0.15);
        }

        /* =========================================
           TAB SWITCHER
        ========================================= */
        .tab-switcher {
            display: flex;
            border-bottom: 1.5px solid var(--border);
            margin-bottom: 32px;
            gap: 0;
        }

        .tab-btn {
            flex: 1;
            background: none;
            border: none;
            padding: 12px 0 14px;
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 0.8rem;
            font-weight: 700;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: var(--text-muted);
            cursor: pointer;
            position: relative;
            transition: color 0.3s;
        }

        .tab-btn::after {
            content: '';
            position: absolute;
            bottom: -1.5px;
            left: 0; right: 0;
            height: 2.5px;
            background: var(--emerald);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

        .tab-btn.active {
            color: var(--emerald);
        }

        .tab-btn.active::after {
            transform: scaleX(1);
        }

        /* =========================================
           FORM HEADINGS
        ========================================= */
        .form-heading {
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 1.75rem;
            font-weight: 800;
            color: var(--dark-navy);
            margin-bottom: 28px;
            line-height: 1.2;
        }

        /* =========================================
           INPUT FIELDS
        ========================================= */
        .field-group {
            margin-bottom: 16px;
        }

        .field-group label {
            display: block;
            font-size: 0.72rem;
            font-weight: 700;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 7px;
        }

        .input-wrap {
            position: relative;
        }

        .input-wrap i:not(.bi-eye-slash):not(.bi-eye) {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            font-size: 1rem;
            pointer-events: none;
        }

        .input-wrap .toggle-pw {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            font-size: 1rem;
            cursor: pointer;
            pointer-events: all;
            background: none;
            border: none;
            padding: 0;
        }

        .input-wrap input,
        .input-wrap select {
            width: 100%;
            padding: 12px 14px 12px 40px;
            border: 1.5px solid var(--border);
            border-radius: 10px;
            background: var(--light-bg);
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 0.88rem;
            font-weight: 500;
            color: var(--dark-navy);
            transition: 0.25s;
            appearance: none;
            -webkit-appearance: none;
        }

        .input-wrap input::placeholder { color: #c0c5cd; }

        .input-wrap input:focus,
        .input-wrap select:focus {
            outline: none;
            border-color: var(--emerald);
            background: white;
            box-shadow: 0 0 0 4px rgba(0,168,132,0.1);
        }

        /* custom select arrow */
        .input-wrap.has-select::after {
            content: '\F282';
            font-family: 'bootstrap-icons';
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            pointer-events: none;
            font-size: 0.9rem;
        }

        /* =========================================
           BUTTONS
        ========================================= */
        .btn-main {
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 10px;
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 0.82rem;
            font-weight: 800;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 6px;
        }

        .btn-main.login { background: var(--emerald); color: white; }
        .btn-main.register { background: var(--dark-navy); color: white; }

        .btn-main:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }

        .btn-social {
            width: 100%;
            padding: 12px 16px;
            border: 1.5px solid var(--border);
            border-radius: 10px;
            background: white;
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 0.88rem;
            font-weight: 600;
            color: var(--dark-navy);
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transition: 0.25s;
        }

        .btn-social:hover {
            background: var(--light-bg);
            border-color: #ccc;
        }

        .or-divider {
            text-align: center;
            font-size: 0.78rem;
            font-weight: 600;
            color: var(--text-muted);
            margin: 18px 0;
        }

        .switch-link {
            text-align: center;
            font-size: 0.82rem;
            color: var(--text-muted);
            margin-top: 20px;
        }

        .switch-link a {
            color: var(--emerald);
            font-weight: 700;
            text-decoration: none;
        }

        /* =========================================
           SECTION SHOW/HIDE
        ========================================= */
        .auth-section { display: none; }
        .auth-section.active {
            display: block;
            animation: fadeUp 0.45s ease forwards;
        }

        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(16px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        /* =========================================
           RESPONSIVE
        ========================================= */
        @media (max-width: 800px) {
            .brand-panel { display: none; }
            .form-panel { width: 100%; min-width: unset; padding: 36px 28px; }
        }
    </style>
</head>
<body>

<!-- Full-bleed background -->
<div class="portal-bg" id="portalBg"></div>

<div class="portal-wrapper">

    <!-- LEFT: Brand -->
    <div class="brand-panel">
        <div class="brand-logo">
            <div class="logo-icon"><i class="bi bi-house-fill"></i></div>
            <span>Property Hub</span>
        </div>

        <div>
            <p class="brand-subtitle" id="brandSubtitle">Elevating Your Living Experience</p>
            <h1 class="brand-title">Marcellus<br>Property Hub</h1>
            <p class="brand-location">Colombo, Sri Lanka</p>
        </div>
    </div>

    <!-- RIGHT: Form Card -->
    <div class="form-panel">

        <c:if test="${not empty error}">
            <div class="alert alert-danger" style="border-radius: 10px; font-size: 0.85rem;">${error}</div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger" style="border-radius: 10px; font-size: 0.85rem;">${param.error}</div>
        </c:if>
        <c:if test="${param.msg == 'registered'}">
            <div class="alert alert-success" style="border-radius: 10px; font-size: 0.85rem;">Registration successful! Please log in below.</div>
        </c:if>
        <c:if test="${param.msg == 'error'}">
            <div class="alert alert-danger" style="border-radius: 10px; font-size: 0.85rem;">An error occurred. Please try again.</div>
        </c:if>

        <!-- Tab Switcher -->
        <div class="tab-switcher">
            <button class="tab-btn active" id="tabLogin" onclick="switchForm('login')">Login</button>
            <button class="tab-btn" id="tabRegister" onclick="switchForm('register')">Register</button>
        </div>

        <!-- LOGIN -->
        <div id="loginSection" class="auth-section active">
            <h2 class="form-heading">Welcome Back!</h2>

            <form action="${pageContext.request.contextPath}/login" method="post">

                <div class="field-group">
                    <label>User Role</label>
                    <div class="input-wrap has-select">
                        <i class="bi bi-person-badge"></i>
                        <select name="role">
                            <option value="BUYER">BUYER</option>
                            <option value="SELLER">SELLER</option>
                            <option value="ADMIN">ADMIN</option>
                        </select>
                    </div>
                </div>

                <div class="field-group">
                    <label>Email</label>
                    <div class="input-wrap">
                        <i class="bi bi-envelope"></i>
                        <input type="email" name="email" placeholder="name@propertyhub.com" required>
                    </div>
                </div>

                <div class="field-group">
                    <label>Secret Key</label>
                    <div class="input-wrap">
                        <i class="bi bi-lock"></i>
                        <input type="password" name="password" id="loginPw" placeholder="••••••••" required>
                        <button type="button" class="toggle-pw" onclick="togglePw('loginPw', this)">
                            <i class="bi bi-eye-slash"></i>
                        </button>
                    </div>
                </div>

                <button type="submit" class="btn-main login">LOGIN TO HUB</button>
            </form>

            <div class="or-divider">or</div>

            <div style="display:flex; flex-direction:column; gap:10px;">
                <button type="button" onclick="loginWithProvider('google')" class="btn-social">
                    <img src="https://upload.wikimedia.org/wikipedia/commons/c/c1/Google_%22G%22_logo.svg" width="18" alt="Google">
                    Log in with Google
                </button>
                <button type="button" onclick="loginWithProvider('facebook')" class="btn-social">
                    <i class="bi bi-facebook" style="font-size:1.15rem; color: #1877F2;"></i>
                    Log in with Facebook
                </button>
                <button type="button" onclick="loginWithProvider('apple')" class="btn-social">
                    <i class="bi bi-apple" style="font-size:1.15rem;"></i>
                    Log in with Apple
                </button>
            </div>

            <p class="switch-link">
                <a href="#" onclick="switchForm('register')">Create an Account</a>
            </p>
        </div>

        <!-- REGISTER -->
        <div id="registerSection" class="auth-section">
            <h2 class="form-heading">Create Account</h2>

            <form action="${pageContext.request.contextPath}/users/register" method="post">

                <div style="display:grid; grid-template-columns:1fr 1fr; gap:12px;">
                    <div class="field-group">
                        <label>Full Name</label>
                        <div class="input-wrap">
                            <i class="bi bi-person"></i>
                            <input type="text" name="name" placeholder="John Doe" required>
                        </div>
                    </div>
                    <div class="field-group">
                        <label>Username</label>
                        <div class="input-wrap">
                            <i class="bi bi-at"></i>
                            <input type="text" name="username_display" placeholder="johndoe24" required>
                        </div>
                    </div>
                </div>

                <div class="field-group">
                    <label>Email Address</label>
                    <div class="input-wrap">
                        <i class="bi bi-envelope"></i>
                        <input type="email" name="email" placeholder="example@mail.com" required>
                    </div>
                </div>

                <div class="field-group">
                    <label>I want to...</label>
                    <div class="input-wrap has-select">
                        <i class="bi bi-house-door"></i>
                        <select name="type">
                            <option value="BUYER">Buy / Rent Property</option>
                            <option value="SELLER">Real Estate Seller</option>
                        </select>
                    </div>
                </div>

                <div class="field-group">
                    <label>Create Password</label>
                    <div class="input-wrap">
                        <i class="bi bi-lock"></i>
                        <input type="password" name="password" id="regPw" placeholder="••••••••" required>
                        <button type="button" class="toggle-pw" onclick="togglePw('regPw', this)">
                            <i class="bi bi-eye-slash"></i>
                        </button>
                    </div>
                </div>

                <button type="submit" class="btn-main register">CREATE ACCOUNT</button>
            </form>

            <p class="switch-link mt-3">Already a member? <a href="#" onclick="switchForm('login')">Login Here</a></p>
        </div>

        <form id="oauth-form" action="${pageContext.request.contextPath}/oauth-login" method="post" style="display:none;">
            <input type="hidden" name="email" id="oauth-email">
            <input type="hidden" name="name" id="oauth-name">
        </form>

        <div class="mt-auto pt-4 text-center">
            <p class="small text-muted mb-0">
                &copy; 2026 Property Hub. <a href="${pageContext.request.contextPath}/privacy-policy" class="text-decoration-none text-muted opacity-75">Privacy Policy</a> | <a href="${pageContext.request.contextPath}/terms-of-service" class="text-decoration-none text-muted opacity-75">Terms of Service</a>
            </p>
        </div>

    </div>
</div>

<script>
    function switchForm(target) {
        const loginSection   = document.getElementById('loginSection');
        const registerSection = document.getElementById('registerSection');
        const tabLogin       = document.getElementById('tabLogin');
        const tabRegister    = document.getElementById('tabRegister');
        const bg             = document.getElementById('portalBg');
        const subtitle       = document.getElementById('brandSubtitle');

        if (target === 'register') {
            loginSection.classList.remove('active');
            registerSection.classList.add('active');
            tabLogin.classList.remove('active');
            tabRegister.classList.add('active');
            bg.classList.add('reg-mode');
            subtitle.textContent = 'Join the Elite Network';
        } else {
            registerSection.classList.remove('active');
            loginSection.classList.add('active');
            tabRegister.classList.remove('active');
            tabLogin.classList.add('active');
            bg.classList.remove('reg-mode');
            subtitle.textContent = 'Elevating Your Living Experience';
        }
    }

    function togglePw(id, btn) {
        const input = document.getElementById(id);
        const icon  = btn.querySelector('i');
        if (input.type === 'password') {
            input.type = 'text';
            icon.classList.replace('bi-eye-slash', 'bi-eye');
        } else {
            input.type = 'password';
            icon.classList.replace('bi-eye', 'bi-eye-slash');
        }
    }
</script>

<!-- Firebase Integration -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/11.0.1/firebase-app.js";
  import { getAuth, signInWithPopup, GoogleAuthProvider, FacebookAuthProvider, OAuthProvider } from "https://www.gstatic.com/firebasejs/11.0.1/firebase-auth.js";

  const firebaseConfig = {
    projectId: "app-trial-fdca1",
    appId: "1:356657191957:web:1d5e89e128a01ba03c421c",
    storageBucket: "app-trial-fdca1.firebasestorage.app",
    apiKey: "AIzaSyBU4hjAL7cYDDqUKaXqg1SX3NI-7e0SiCQ",
    authDomain: "app-trial-fdca1.firebaseapp.com",
    messagingSenderId: "356657191957",
    measurementId: "G-XSFSD1D67G"
  };

  const app = initializeApp(firebaseConfig);
  const auth = getAuth(app);

  window.loginWithProvider = function(providerType) {
      let provider;
      if (providerType === 'google') provider = new GoogleAuthProvider();
      else if (providerType === 'facebook') provider = new FacebookAuthProvider();
      else if (providerType === 'apple') provider = new OAuthProvider('apple.com');
      
      signInWithPopup(auth, provider).then((result) => {
          const user = result.user;
          document.getElementById('oauth-email').value = user.email;
          document.getElementById('oauth-name').value = user.displayName || 'Social User';
          document.getElementById('oauth-form').submit();
      }).catch((error) => {
          console.error(error);
          alert("Error during " + providerType + " sign in: " + error.message);
      });
  };
</script>

</body>
</html>
