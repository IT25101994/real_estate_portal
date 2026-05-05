<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    /* Top Contact Bar */
    .top-contact-bar {
        background: var(--dark-navy);
        color: rgba(255,255,255,0.7);
        padding: 10px 60px;
        font-size: 13px;
        display: flex;
        justify-content: space-between;
        position: fixed;
        width: 100%;
        top: 0;
        z-index: 1002;
    }

    /* Navigation Bar */
    .premium-nav {
        padding: 15px 60px;
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

    .premium-nav .brand { font-size: 24px; font-weight: bold; color: var(--dark-navy); letter-spacing: 2px; }
    
    .nav-links a {
        text-decoration: none;
        color: var(--dark-navy);
        font-weight: 600;
        font-size: 13px;
        transition: color 0.3s;
    }
    .nav-links a:hover { color: var(--emerald); }
    
    .content-wrapper { padding-top: 120px; } /* Adjust for fixed headers */
</style>

<div class="top-contact-bar d-none d-lg-flex">
    <div>
        <span class="me-4"><i class="bi bi-telephone-fill text-success me-2"></i> +94 112 345 678</span>
        <span><i class="bi bi-envelope-fill text-success me-2"></i> support@propertyhub.lk</span>
    </div>
    <div>
        <span class="me-3">FOLLOW US:</span>
        <a href="#" class="text-white-50 me-2 text-decoration-none"><i class="bi bi-facebook"></i></a>
        <a href="#" class="text-white-50 me-2 text-decoration-none"><i class="bi bi-instagram"></i></a>
        <a href="#" class="text-white-50 text-decoration-none"><i class="bi bi-linkedin"></i></a>
    </div>
</div>

<nav class="premium-nav">
    <a href="${pageContext.request.contextPath}/dashboard" class="brand">PROPERTY<span>HUB</span></a>
    
    <div class="nav-links d-none d-lg-flex gap-4 align-items-center">
        <a href="${pageContext.request.contextPath}/dashboard">HOME</a>
        <a href="${pageContext.request.contextPath}/properties?action=list">PROPERTIES</a>
        
        <c:if test="${sessionScope.user != null && (sessionScope.user.type == 'ADMIN' || sessionScope.user.type == 'admin')}">
            <a href="${pageContext.request.contextPath}/reviews?action=list">REVIEWS</a>
        </c:if>

        <c:if test="${sessionScope.user != null && (sessionScope.user.type == 'SELLER' || sessionScope.user.type == 'ADMIN' || sessionScope.user.type == 'admin')}">
            <a href="${pageContext.request.contextPath}/inquiries?action=list">INQUIRIES</a>
        </c:if>

        <c:if test="${sessionScope.user != null}">
            <a href="${pageContext.request.contextPath}/logout" class="text-danger">LOGOUT</a>
        </c:if>
        
        <c:if test="${sessionScope.user == null}">
            <a href="${pageContext.request.contextPath}/login" class="text-primary">LOGIN</a>
        </c:if>
    </div>

    <c:if test="${sessionScope.user != null && sessionScope.user.type != 'BUYER' && sessionScope.user.type != 'buyer'}">
        <button class="btn btn-dark rounded-pill px-4 fw-bold shadow-sm" onclick="window.location.href='${pageContext.request.contextPath}/properties?action=addForm'">Post Ad</button>
    </c:if>
    <c:if test="${sessionScope.user == null}">
         <button class="btn btn-emerald rounded-pill px-4 fw-bold shadow-sm" style="background: var(--emerald); color: white;" onclick="window.location.href='${pageContext.request.contextPath}/register'">Join Us</button>
    </c:if>
</nav>

<div class="content-wrapper"></div>
