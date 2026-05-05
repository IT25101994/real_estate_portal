<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="common/common-head.jsp" />
    <title>Contact Us | Property Hub Sri Lanka</title>
    <style>
        .contact-header {
            background: var(--dark-navy);
            padding: 120px 0 100px;
            color: white;
            border-bottom-left-radius: 80px;
        }
        .contact-grid {
            margin-top: -60px;
            position: relative;
            z-index: 20;
        }
        .contact-info-card {
            background: #fff;
            border-radius: 30px;
            padding: 50px;
            box-shadow: 0 40px 100px rgba(0,0,0,0.05);
            border: 1px solid #f0f0f0;
            height: 100%;
        }
        .form-card {
            background: #fff;
            border-radius: 30px;
            padding: 50px;
            box-shadow: 0 40px 100px rgba(0,0,0,0.08);
            border: 1px solid #f0f0f0;
        }
        .info-item { margin-bottom: 40px; display: flex; align-items: flex-start; gap: 20px; }
        .info-icon { 
            width: 50px; height: 50px; border-radius: 15px; 
            background: rgba(0, 168, 132, 0.1); color: var(--emerald);
            display: flex; align-items: center; justify-content: center; font-size: 1.5rem; flex-shrink: 0;
        }
        .info-text h6 { font-weight: 700; color: var(--dark-navy); margin-bottom: 5px; text-transform: uppercase; letter-spacing: 1px; }
        .info-text p { color: var(--text-muted); margin-bottom: 0; font-size: 0.95rem; }

        .map-container {
            width: 100%; height: 350px; border-radius: 25px; overflow: hidden;
            border: 5px solid #fff; box-shadow: 0 10px 30px rgba(0,0,0,0.1); margin-top: 30px;
        }
    </style>
</head>
<body>

<jsp:include page="common/header.jsp" />

<div class="contact-header">
    <div class="container text-center">
        <h1 class="display-3 fw-bold font-marcellus">Contact Us</h1>
        <p class="opacity-75 fs-5">We are here to help you find your dream property in Sri Lanka.</p>
    </div>
</div>

<div class="container contact-grid mb-5">
    <div class="row g-4">
        <div class="col-lg-5">
            <div class="contact-info-card">
                <h3 class="fw-bold font-marcellus mb-5">Get In Touch</h3>
                
                <div class="info-item">
                    <div class="info-icon"><i class="bi bi-geo-alt"></i></div>
                    <div class="info-text">
                        <h6>Main Office</h6>
                        <p>No 123, Luxury Plaza,<br>Colombo 07, Sri Lanka 10100.</p>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon"><i class="bi bi-telephone"></i></div>
                    <div class="info-text">
                        <h6>Inquiry Hotline</h6>
                        <p>+94 112 345 678<br>+94 771 234 567</p>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon"><i class="bi bi-envelope"></i></div>
                    <div class="info-text">
                        <h6>Email Reach</h6>
                        <p>general@propertyhub.lk<br>sales@propertyhub.lk</p>
                    </div>
                </div>

                <div class="map-container">
                    <!-- Placeholder UI for Map -->
                    <div class="w-100 h-100 bg-light d-flex flex-column align-items-center justify-content-center text-center p-4">
                        <i class="bi bi-map-fill display-4 text-emerald mb-3"></i>
                        <p class="fw-bold text-dark mb-1">Interactive Office Map</p>
                        <p class="small text-muted">Colombo 07 Hub Location Active</p>
                        <button class="btn btn-emerald btn-sm rounded-pill px-4 mt-2">View Full Map</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-7">
            <div class="form-card">
                <h3 class="fw-bold font-marcellus mb-4">Send a Message</h3>
                <p class="text-muted mb-5">If you have a specific property request or a general query, please use the form below and our team will get back to you within 24 hours.</p>
                
                <form action="#" method="post">
                    <div class="row g-4">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted text-uppercase">Your Name</label>
                            <input type="text" class="form-control form-control-lg border-light bg-light" placeholder="e.g. Aruni Perera" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted text-uppercase">Email Address</label>
                            <input type="email" class="form-control form-control-lg border-light bg-light" placeholder="name@example.com" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label small fw-bold text-muted text-uppercase">Subject</label>
                            <input type="text" class="form-control form-control-lg border-light bg-light" placeholder="e.g. Listing Assistance" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label small fw-bold text-muted text-uppercase">Your Message</label>
                            <textarea class="form-control border-light bg-light" rows="6" placeholder="Tell us how we can help..." required></textarea>
                        </div>
                        <div class="col-12 mt-4">
                            <button type="submit" class="btn btn-premium w-100 py-3 shadow">SEND MESSAGE</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />

</body>
</html>
