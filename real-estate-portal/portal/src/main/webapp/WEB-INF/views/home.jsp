<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Elite Estates | Property Hub Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Marcellus&family=Plus+Jakarta+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --gold: #c5a059;
            --dark-navy: #0a1128;
            --emerald: #00b98e;
            --orange: #ff5a3c;
            --white: #ffffff;
        }

        body { font-family: 'Plus Jakarta Sans', sans-serif; background: #fff; color: var(--dark-navy); overflow-x: hidden; }

        .top-contact-bar {
            background: var(--dark-navy);
            color: rgba(255,255,255,0.7);
            padding: 10px 60px;
            font-size: 13px;
            display: flex;
            justify-content: space-between;
            position: fixed;
            width: 100%;
            z-index: 1002;
        }

        .premium-nav {
            padding: 20px 60px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(15px);
            position: fixed;
            width: 100%;
            z-index: 1001;
            top: 40px;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            box-shadow: 0 5px 20px rgba(0,0,0,0.02);
        }
        .brand { font-family: 'Marcellus', serif; font-size: 26px; font-weight: bold; color: var(--dark-navy); letter-spacing: 2px; text-decoration: none; }
        .brand span { color: var(--emerald); }

        .hero-luxury {
            height: 90vh;
            background: linear-gradient(rgba(0,0,0,0.45), rgba(0,0,0,0.45)),
                        url('https://images.unsplash.com/photo-1613490493576-7fde63acd811?q=80&w=2071&auto=format&fit=crop');
            background-size: cover;
            background-position: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: white;
            text-align: center;
            border-bottom-left-radius: 100px;
            padding-top: 120px;
        }
        .hero-luxury h1 { font-family: 'Marcellus', serif; font-size: clamp(40px, 6vw, 75px); margin-bottom: 20px; }

        /* --- PRE-RE-DESIGNED PREMIUM SEARCH BAR --- */
        .luxury-search-container {
            width: 90%;
            max-width: 1100px;
            margin-top: -60px;
            position: relative;
            z-index: 100;
        }

        .luxury-search {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(10px);
            padding: 15px;
            border-radius: 100px; /* Pill Shape */
            display: flex;
            align-items: center;
            box-shadow: 0 25px 60px rgba(0,0,0,0.15);
            border: 1px solid rgba(255,255,255,0.8);
            transition: 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
        }

        .luxury-search:hover {
            transform: translateY(-5px);
            box-shadow: 0 35px 80px rgba(0,0,0,0.2);
        }

        .search-group {
            flex: 1;
            padding: 0 30px;
            border-right: 1px solid rgba(0,0,0,0.06);
            display: flex;
            flex-direction: column;
        }

        .search-group:last-child {
            border-right: none;
            flex: 0 0 auto;
            padding-right: 10px;
        }

        .search-label {
            font-size: 10px;
            text-transform: uppercase;
            color: var(--emerald);
            font-weight: 800;
            margin-bottom: 5px;
            letter-spacing: 1.5px;
        }

        .search-field {
            border: none;
            background: transparent;
            font-weight: 600;
            font-size: 16px;
            color: var(--dark-navy);
            padding: 0;
            cursor: pointer;
            width: 100%;
        }

        .search-field:focus {
            outline: none;
            box-shadow: none;
        }

        .btn-search-main {
            background: var(--dark-navy);
            color: white;
            width: 65px;
            height: 65px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            border: none;
            transition: 0.4s;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }

        .btn-search-main:hover {
            background: var(--orange);
            transform: scale(1.1) rotate(90deg);
            color: white;
        }

        /* Mobile Adjustments for Search */
        @media (max-width: 991px) {
            .luxury-search {
                border-radius: 25px;
                flex-direction: column;
                padding: 25px;
            }
            .search-group {
                border-right: none;
                border-bottom: 1px solid #eee;
                width: 100%;
                padding: 15px 0;
            }
            .btn-search-main {
                width: 100%;
                border-radius: 12px;
                margin-top: 15px;
                height: 55px;
            }
            .btn-search-main i::after {
                content: ' SEARCH NOW';
                font-family: 'Plus Jakarta Sans', sans-serif;
                font-size: 14px;
                font-weight: 700;
                margin-left: 10px;
            }
        }

        /* --- REST OF THE CODE (UNTOUCHED) --- */
        .menu-section { padding: 100px 0; }
        .menu-card {
            background: white; border: 1px solid #f0f0f0; border-radius: 25px; padding: 45px 30px;
            text-align: center; transition: 0.5s; cursor: pointer; text-decoration: none; display: block;
        }
        .menu-card:hover {
            background: var(--dark-navy); color: white !important;
            transform: translateY(-20px); border-color: var(--dark-navy);
        }
        .menu-card i { font-size: 45px; color: var(--gold); margin-bottom: 25px; display: block; }
        .menu-card h5 { font-weight: 700; margin-bottom: 10px; }

        footer { background: #f8f9fa; padding: 80px 0 30px; border-top: 1px solid #eee; }
        footer .brand { font-size: 22px; }
        .footer-link { color: #666; text-decoration: none; transition: 0.3s; }
        .footer-link:hover { color: var(--emerald); }
    </style>
</head>
<body>

<div class="top-contact-bar d-none d-lg-flex">
    <div>
        <span class="me-4"><i class="bi bi-telephone-fill text-success me-2"></i> +94 112 345 678</span>
        <span><i class="bi bi-envelope-fill text-success me-2"></i> support@propertyhub.lk</span>
    </div>
    <div>
        <span class="me-3">FOLLOW US:</span>
        <a href="#" class="text-white-50 me-2"><i class="bi bi-facebook"></i></a>
        <a href="#" class="text-white-50 me-2"><i class="bi bi-instagram"></i></a>
        <a href="#" class="text-white-50"><i class="bi bi-linkedin"></i></a>
    </div>
</div>

<nav class="premium-nav">
    <a href="${pageContext.request.contextPath}/dashboard" class="brand">PROPERTY<span>HUB</span></a>
    <div class="d-none d-lg-flex gap-4">
        <a href="${pageContext.request.contextPath}/dashboard" class="text-dark text-decoration-none fw-bold small">HOME</a>
        <a href="${pageContext.request.contextPath}/properties?action=list" class="text-dark text-decoration-none fw-bold small">PROPERTIES</a>
        <a href="${pageContext.request.contextPath}/inquiries?action=list" class="text-dark text-decoration-none fw-bold small">INQUIRIES</a>
        <a href="${pageContext.request.contextPath}/reviews?action=list" class="text-dark text-decoration-none fw-bold small">REVIEWS</a>
        <a href="${pageContext.request.contextPath}/logout" class="text-danger text-decoration-none fw-bold small">LOGOUT</a>
    </div>
    <button class="btn btn-dark rounded-pill px-4 fw-bold shadow-sm" onclick="window.location.href='${pageContext.request.contextPath}/properties?action=addForm'">Post Ad</button>
</nav>

<section class="hero-luxury">
    <p class="text-uppercase fw-bold mb-3" style="letter-spacing: 5px; color: var(--gold);">Since 2026</p>
    <h1>Our lands for sale are <br> <span>meant for your dream home</span></h1>
    <p class="fs-5 opacity-75">All real estate solutions at one stop in Sri Lanka.</p>
</section>

<div class="container luxury-search-container d-flex justify-content-center">
    <form action="${pageContext.request.contextPath}/properties" method="get" class="luxury-search w-100" data-aos="fade-up" data-aos-duration="1000">
        <input type="hidden" name="action" value="search">
        <div class="search-group">
            <span class="search-label">Property Type</span>
            <select name="type" class="search-field form-select shadow-none">
                <option selected disabled>What are you looking for?</option>
                <option value="house">Luxury House</option>
                <option value="apartment">Modern Apartment</option>
                <option value="land">Prime Land</option>
            </select>
        </div>

        <div class="search-group">
            <span class="search-label">Location</span>
            <select name="location" class="search-field form-select shadow-none">
                <option selected disabled>Select City</option>
                <option value="colombo">Colombo</option>
                <option value="kandy">Kandy</option>
                <option value="galle">Galle</option>
            </select>
        </div>

        <div class="search-group">
            <span class="search-label">Budget</span>
            <select name="price" class="search-field form-select shadow-none">
                <option selected disabled>Select Range</option>
                <option value="0-10">Below 10 Million</option>
                <option value="10-50">10 - 50 Million</option>
                <option value="50-100">50 - 100 Million</option>
            </select>
        </div>

        <div class="search-group">
            <button type="submit" class="btn-search-main">
                <i class="bi bi-search"></i>
            </button>
        </div>
    </form>
</div>

<div class="container menu-section">
    <div class="row g-4">
        <div class="col-md-3 col-sm-6">
            <a href="${pageContext.request.contextPath}/properties?action=list" class="menu-card shadow-sm">
                <i class="bi bi-search"></i>
                <h5 class="text-dark">FIND PROPERTIES</h5>
                <p class="text-muted small">Search houses, apartments or land for sale.</p>
            </a>
        </div>
        <div class="col-md-3 col-sm-6">
            <a href="${pageContext.request.contextPath}/properties?action=search&status=For Rent" class="menu-card shadow-sm">
                <i class="bi bi-key"></i>
                <h5 class="text-dark">FOR RENT</h5>
                <p class="text-muted small">Explore houses or apartments for lease.</p>
            </a>
        </div>
        <div class="col-md-3 col-sm-6">
            <a href="${pageContext.request.contextPath}/properties?action=addForm" class="menu-card shadow-sm">
                <i class="bi bi-megaphone"></i>
                <h5 class="text-dark">POST YOUR AD</h5>
                <p class="text-muted small">Advertise your property to millions.</p>
            </a>
        </div>
        <div class="col-md-3 col-sm-6">
            <a href="${pageContext.request.contextPath}/market-trends" class="menu-card shadow-sm">
                <i class="bi bi-graph-up-arrow"></i>
                <h5 class="text-dark">MARKET TRENDS</h5>
                <p class="text-muted small">Compare and find the best home rates.</p>
            </a>
        </div>
    </div>
</div>

<footer>
    <div class="container">
        <div class="row g-5 text-start">
            <div class="col-lg-4">
                <a class="brand mb-3 d-block">PROPERTY<span>HUB</span></a>
                <p class="text-muted small lh-lg">Sri Lanka's most trusted real estate partner. Whether you're looking for a luxury villa or a prime piece of land, we've got you covered.</p>
            </div>

            <div class="col-lg-2 col-md-4">
                <h6 class="fw-bold mb-4">Quick Links</h6>
                <div class="d-flex flex-column gap-2">
                    <a href="#" class="footer-link small">Privacy Policy</a>
                    <a href="#" class="footer-link small">Terms of Service</a>
                </div>
            </div>

            <div class="col-lg-3 col-md-4">
                <h6 class="fw-bold mb-4">Direct Contact</h6>
                <div class="d-flex align-items-center mb-4">
                    <div class="bg-white shadow-sm rounded-3 p-3 me-3 text-success fs-4"><i class="bi bi-telephone"></i></div>
                    <div>
                        <p class="mb-0 small fw-bold">Customer Hotline</p>
                        <p class="mb-0 small text-muted">+94 771 234 567</p>
                    </div>
                </div>
            </div>

            <div class="col-lg-3 col-md-4">
                <h6 class="fw-bold mb-4">Newsletter</h6>
                <div class="input-group">
                    <input type="email" class="form-control border-0 shadow-sm" placeholder="Your Email">
                    <button class="btn btn-success"><i class="bi bi-send-fill"></i></button>
                </div>
            </div>
        </div>
        <hr class="my-5 opacity-25">
        <div class="text-center">
            <p class="text-muted small mb-0">&copy; 2026 Property Hub (Pvt) Ltd. All Rights Reserved.</p>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    AOS.init();
</script>
</body>
</html>
