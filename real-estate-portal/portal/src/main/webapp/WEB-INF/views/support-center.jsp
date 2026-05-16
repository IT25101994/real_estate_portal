<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="common/common-head.jsp" />
    <title>Support Center | Property Hub Sri Lanka</title>
    <style>
        .support-header {
            background: var(--dark-navy);
            padding: 120px 0 100px;
            color: white;
            border-bottom-left-radius: 80px;
        }
        .support-card {
            background: #fff;
            border-radius: 30px;
            padding: 60px;
            box-shadow: 0 40px 100px rgba(0,0,0,0.05);
            border: 1px solid #f0f0f0;
            margin-top: -60px;
            position: relative;
            z-index: 20;
        }
        .faq-item {
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #f8f9fa;
        }
        .faq-question {
            font-weight: 700;
            color: var(--dark-navy);
            font-size: 1.15rem;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
        }
        .faq-question i { color: var(--emerald); margin-right: 15px; font-size: 1.4rem; }
        .faq-answer {
            color: var(--text-muted);
            line-height: 1.7;
            padding-left: 38px;
        }
        .contact-box {
            background: var(--bg-light);
            border-radius: 20px;
            padding: 30px;
            text-align: center;
            height: 100%;
            transition: 0.3s;
        }
        .contact-box:hover { transform: translateY(-10px); background: white; box-shadow: 0 15px 40px rgba(0,0,0,0.05); }
        .contact-box i { font-size: 2.5rem; color: var(--gold); margin-bottom: 20px; display: block; }
    </style>
</head>
<body>

<jsp:include page="common/header.jsp" />

<div class="support-header">
    <div class="container text-center">
        <h1 class="display-3 fw-bold font-marcellus">Support Center</h1>
        <p class="opacity-75 fs-5">How can we help you with your property journey today?</p>
    </div>
</div>

<div class="container mb-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="support-card">
                <div class="row g-4 mb-5 border-bottom pb-5">
                    <div class="col-md-4">
                        <div class="contact-box">
                            <i class="bi bi-chat-dots"></i>
                            <h5 class="fw-bold">Live Chat</h5>
                            <p class="small text-muted">Instant help from our Sri Lankan support team.</p>
                            <button class="btn btn-emerald btn-sm rounded-pill px-4">Start Chat</button>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="contact-box">
                            <i class="bi bi-telephone"></i>
                            <h5 class="fw-bold">Call Center</h5>
                            <p class="small text-muted">+94 112 345 678<br>(9 AM - 6 PM)</p>
                            <a href="tel:+94112345678" class="btn btn-dark btn-sm rounded-pill px-4">Call Now</a>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="contact-box">
                            <i class="bi bi-envelope"></i>
                            <h5 class="fw-bold">Email Support</h5>
                            <p class="small text-muted">support@propertyhub.lk<br>Average wait: 2 hours</p>
                            <a href="mailto:support@propertyhub.lk" class="btn btn-premium btn-sm rounded-pill px-4">Send Ticket</a>
                        </div>
                    </div>
                </div>

                <h3 class="fw-bold font-marcellus mb-5">Frequently Asked Questions</h3>

                <div class="faq-item">
                    <div class="faq-question">
                        <i class="bi bi-question-circle-fill"></i>
                        How do I list a property for sale in Sri Lanka?
                    </div>
                    <div class="faq-answer">
                        If you are registered as a <strong>Seller</strong>, simply click the "Post Ad" button in the top navigation. You will need to provide the property title, location (e.g., Colombo 07), price in <strong>LKR</strong>, and upload at least one feature image.
                    </div>
                </div>

                <div class="faq-item">
                    <div class="faq-question">
                        <i class="bi bi-question-circle-fill"></i>
                        Can I upload multiple photos for one listing?
                    </div>
                    <div class="faq-answer">
                        Yes! Our platform supports a **Primary Cover Photo** and a **Gallery** section. During property creation, you can select multiple images to provide a comprehensive view of the asset to potential buyers.
                    </div>
                </div>

                <div class="faq-item">
                    <div class="faq-question">
                        <i class="bi bi-question-circle-fill"></i>
                        How can I change my profile photo?
                    </div>
                    <div class="faq-answer">
                        Navigate to **My Profile** in the top menu, hover over your current avatar, and select the "Change Photo" option. Your account will automatically update across the platform, including your reviews and listings.
                    </div>
                </div>

                <div class="faq-item">
                    <div class="faq-question">
                        <i class="bi bi-question-circle-fill"></i>
                        Are inquiries sent directly to sellers?
                    </div>
                    <div class="faq-answer">
                        Yes. When a buyer submits an inquiry from a property detail page, it is immediately routed to the seller's secure dashboard. Sellers can respond directly through the platform.
                    </div>
                </div>

                <div class="faq-item">
                    <div class="faq-question">
                        <i class="bi bi-question-circle-fill"></i>
                        What happens if I forget my secret key?
                    </div>
                    <div class="faq-answer">
                        For security reasons, we do not store plaintext passwords. Please use the "Forgot Password" link on the Login page (v2.4.0 rollout) or contact our system administrators through the live chat above.
                    </div>
                </div>

                <div class="text-center mt-5">
                    <p class="text-muted">Didn't find what you were looking for?</p>
                    <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline-dark rounded-pill px-5">Back to Dashboard</a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />

</body>
</html>
