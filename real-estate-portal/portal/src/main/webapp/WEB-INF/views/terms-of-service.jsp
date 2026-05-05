<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="common/common-head.jsp" />
    <title>Terms of Service | Property Hub Sri Lanka</title>
    <style>
        .tos-header {
            background: var(--dark-navy);
            padding: 120px 0 100px;
            color: white;
            border-bottom-left-radius: 80px;
        }
        .tos-card {
            background: #fff;
            border-radius: 30px;
            padding: 60px;
            box-shadow: 0 40px 100px rgba(0,0,0,0.05);
            border: 1px solid #f0f0f0;
            margin-top: -60px;
            position: relative;
            z-index: 20;
        }
        .tos-section { margin-bottom: 40px; }
        .tos-section h4 { 
            font-family: 'Marcellus', serif; 
            color: var(--dark-navy); 
            font-weight: 700; 
            margin-bottom: 20px;
            border-bottom: 2px solid var(--gold);
            display: inline-block;
            padding-bottom: 5px;
        }
        .tos-section p, .tos-section li { 
            color: var(--text-muted); 
            line-height: 1.8; 
            font-size: 1.05rem;
        }
    </style>
</head>
<body>

<jsp:include page="common/header.jsp" />

<div class="tos-header">
    <div class="container text-center">
        <h1 class="display-3 fw-bold font-marcellus">Terms of Service</h1>
        <p class="opacity-75 fs-5">Governing the use of Sri Lanka's leading real estate platform.</p>
    </div>
</div>

<div class="container mb-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="tos-card">
                <div class="tos-section">
                    <h4>1. Acceptance of Terms</h4>
                    <p>By accessing and using the Property Hub platform, you agree to be bound by these Terms of Service. If you do not agree to these terms, you should not use the application or services provided in the Sri Lankan region.</p>
                </div>

                <div class="tos-section">
                    <h4>2. User Responsibilities</h4>
                    <p>Users, including Buyers, Sellers, and Administrators, are responsible for maintaining the confidentiality of their credentials. You are solely responsible for all activities that occur under your account, including property listings and inquiries sent through our secure dashboard.</p>
                </div>

                <div class="tos-section">
                    <h4>3. Property Listings (LKR)</h4>
                    <p>Sellers and property owners must ensure that all listing details, including images, descriptions, and prices in Sri Lankan Rupees (Rs.), are accurate and not misleading. We reserve the right to remove any listing that violates our quality standards or governance policies.</p>
                </div>

                <div class="tos-section">
                    <h4>4. Seller Conduct & Reviews</h4>
                    <p>Reviews submitted for properties and sellers must be authentic and based on genuine interactions. Any attempt to manipulate ratings or post fraudulent feedback will result in account suspension and possible blacklisting from the platform.</p>
                </div>

                <div class="tos-section">
                    <h4>5. Service Limitations</h4>
                    <p>While we strive for 100% uptime, Property Hub (Pvt) Ltd. is not liable for temporary service interruptions due to maintenance or technical upgrades (v2.4.0 rollout). We provide the platform "as-is" for real estate networking purposes.</p>
                </div>

                <div class="tos-section">
                    <h4>6. Governing Law</h4>
                    <p>These terms are governed by the laws of the Democratic Socialist Republic of Sri Lanka. Any disputes arising from the use of this portal shall be subject to the exclusive jurisdiction of the courts in Colombo.</p>
                </div>

                <hr class="my-5 opacity-25">
                
                <div class="text-center text-muted small">
                    <p>Last Updated: March 2026</p>
                    <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline-dark rounded-pill px-4 btn-sm mt-3">Accept and Proceed</a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />

</body>
</html>
