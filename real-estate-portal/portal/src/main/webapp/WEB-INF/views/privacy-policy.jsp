<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="common/common-head.jsp" />
    <title>Privacy Policy | Property Hub Sri Lanka</title>
    <style>
        .pp-header {
            background: var(--dark-navy);
            padding: 120px 0 100px;
            color: white;
            border-bottom-left-radius: 80px;
        }
        .policy-card {
            background: #fff;
            border-radius: 30px;
            padding: 60px;
            box-shadow: 0 40px 100px rgba(0,0,0,0.05);
            border: 1px solid #f0f0f0;
            margin-top: -60px;
            position: relative;
            z-index: 20;
        }
        .policy-section { margin-bottom: 40px; }
        .policy-section h4 { 
            font-family: 'Marcellus', serif; 
            color: var(--dark-navy); 
            font-weight: 700; 
            margin-bottom: 20px;
            border-bottom: 2px solid var(--emerald);
            display: inline-block;
            padding-bottom: 5px;
        }
        .policy-section p, .policy-section li { 
            color: var(--text-muted); 
            line-height: 1.8; 
            font-size: 1.05rem;
        }
    </style>
</head>
<body>

<jsp:include page="common/header.jsp" />

<div class="pp-header">
    <div class="container text-center">
        <h1 class="display-3 fw-bold font-marcellus">Privacy Policy</h1>
        <p class="opacity-75 fs-5">Your data protection and privacy are our highest priority.</p>
    </div>
</div>

<div class="container mb-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="policy-card">
                <div class="policy-section">
                    <h4>1. Information Collection</h4>
                    <p>We collect information that you provide directly to us when you create an account, list a property, or communicate with sellers. This may include your name, email address, phone number, and any property-related documentation you upload to our platform in Sri Lanka.</p>
                </div>

                <div class="policy-section">
                    <h4>2. Use of Information</h4>
                    <p>The information we collect is used to facilitate real estate transactions, provide personalized alerts for properties in your preferred locations (like Colombo, Kandy, or Galle), and improve our administrative oversight tools. We also use your contact data to send you inquiries from potential buyers or tenants.</p>
                </div>

                <div class="policy-section">
                    <h4>3. Profile Photos & Identity</h4>
                    <p>When you upload a profile photo, it is stored on our secure servers and displayed across the platform to provide a more authentic and trustworthy social experience for other users. Your photo identifies you to potential clients and other platform members.</p>
                </div>

                <div class="policy-section">
                    <h4>4. Data Sharing</h4>
                    <p>We do not sell your personal data to third parties. Your information is only shared with platform members (such as sellers or buyers) that you explicitly interact with through our inquiry and review systems.</p>
                </div>

                <div class="policy-section">
                    <h4>5. Security Measures</h4>
                    <p>We implement industry-standard security protocols to protect your data from unauthorized access, alteration, or disclosure. Our platform is regularly patched (v2.4.0 active) to ensure the highest level of governance and security.</p>
                </div>

                <div class="policy-section">
                    <h4>6. Your Rights</h4>
                    <p>You have the right to access, update, or delete your personal information at any time through your Profile Dashboard. For any specific data requests, you can reach out to our system administrators.</p>
                </div>

                <hr class="my-5 opacity-25">
                
                <div class="text-center text-muted small">
                    <p>Last Updated: March 2026</p>
                    <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline-dark rounded-pill px-4 btn-sm mt-3">Return to Dashboard</a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />

</body>
</html>
