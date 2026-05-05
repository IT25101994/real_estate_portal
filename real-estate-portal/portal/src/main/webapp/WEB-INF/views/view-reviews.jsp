<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="common/common-head.jsp" />
    <title>View Reviews | Property Hub</title>
    <style>
        .page-header {
            background: var(--dark-navy);
            padding: 100px 0 80px;
            color: white;
            border-bottom-left-radius: 60px;
        }
        .stats-card {
            background: #fff; border-radius: 20px; border: 1px solid var(--border-color);
            box-shadow: 0 10px 30px rgba(0,0,0,0.05); padding: 40px;
            margin-top: -50px; position: relative; z-index: 10;
        }
        .review-card {
            background: #fff;
            border-radius: 15px;
            border: 1px solid #eee;
            padding: 30px;
            height: 100%;
            transition: all 0.3s ease;
        }
        .review-card:hover {
            border-color: var(--emerald);
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        }
        .author-info {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
        }
        .author-img {
            width: 45px; height: 45px; border-radius: 50%;
            background: #f8f9fa; display: flex; align-items: center; justify-content: center;
            color: var(--emerald); font-weight: 700;
        }
    </style>
</head>
<body>

<jsp:include page="common/header.jsp" />

<div class="page-header">
    <div class="container text-center">
        <h1 class="display-5 fw-bold font-marcellus">Asset Reputation</h1>
        <p class="opacity-75">Public testimonials and verification for ${param.targetType} #${param.targetId}</p>
    </div>
</div>

<div class="container mb-5">
    <div class="stats-card text-center mb-5">
        <div class="row align-items-center">
            <div class="col-md-6 border-end">
                <h6 class="text-muted text-uppercase small ls-1 mb-2">Aggregate Rating</h6>
                <div class="display-4 fw-bold text-dark mb-0">${averageRating} <small class="fs-6 text-muted">/ 5.0</small></div>
            </div>
            <div class="col-md-6">
                <h6 class="text-muted text-uppercase small ls-1 mb-2">Total Verifications</h6>
                <div class="display-4 fw-bold text-dark mb-0">${reviews.size()} <small class="fs-6 text-muted">Testimonials</small></div>
            </div>
        </div>
    </div>

    <div class="row g-4">
        <c:forEach var="review" items="${reviews}">
            <div class="col-md-6">
                <div class="review-card">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <div class="author-info">
                            <div class="author-img">
                                <c:choose>
                                    <c:when test="${not empty review.userPhoto}">
                                        <img src="${pageContext.request.contextPath}/${review.userPhoto}" class="w-100 h-100 rounded-circle" style="object-fit: cover;">
                                    </c:when>
                                    <c:otherwise>
                                        <i class="bi bi-person"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div>
                                <h6 class="fw-bold m-0 text-dark">${review.userName}</h6>
                                <small class="text-muted">Status: Verified Member</small>
                            </div>
                        </div>
                        <div class="text-warning small">${review.stars}</div>
                    </div>
                    <p class="text-muted italic mb-0">"${review.comment}"</p>
                </div>
            </div>
        </c:forEach>
        
        <c:if test="${empty reviews}">
            <div class="col-12 text-center py-5">
                <i class="bi bi-chat-left-dots display-1 text-muted opacity-25 d-block mb-3"></i>
                <h4 class="text-muted">No reviews have been logged for this asset yet.</h4>
            </div>
        </c:if>
    </div>
    
    <div class="text-center mt-5">
        <a href="${pageContext.request.contextPath}/reviews?action=list" class="btn btn-outline-dark rounded-pill px-4 fw-bold">Return to Management</a>
    </div>
</div>

<jsp:include page="common/footer.jsp" />

</body>
</html>
