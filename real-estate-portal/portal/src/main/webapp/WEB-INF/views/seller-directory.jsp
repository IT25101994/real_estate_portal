<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="common/common-head.jsp" />
    <title>Seller Directory | Property Hub</title>
    <style>
        .page-header {
            background: var(--dark-navy);
            padding: 100px 0 80px;
            color: white;
            border-bottom-left-radius: 60px;
        }
        .seller-card {
            background: #fff;
            border-radius: 20px;
            border: 1px solid var(--border-color);
            transition: all 0.4s ease;
            height: 100%;
            overflow: hidden;
            text-align: center;
            padding: 40px 20px;
        }
        .seller-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.08);
            border-color: var(--emerald);
        }
        .seller-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            border: 4px solid #f8f9fa;
            margin-bottom: 20px;
            object-fit: cover;
        }
        .tier-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 30px;
            font-size: 0.7rem;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 15px;
        }
        .search-area {
            margin-top: -50px;
            position: relative;
            z-index: 10;
        }
    </style>
</head>
<body>

<jsp:include page="common/header.jsp" />

<div class="page-header">
    <div class="container text-center">
        <h1 class="display-5 fw-bold font-marcellus">Our Expert Sellers</h1>
        <p class="opacity-75">Connect with the finest real estate professionals in the island.</p>
    </div>
</div>

<div class="container search-area mb-5">
    <div class="luxury-search-small p-4 bg-white shadow-sm rounded-4 border">
        <form action="${pageContext.request.contextPath}/sellers" method="get" class="row g-3">
            <input type="hidden" name="action" value="search">
            <div class="col-md-9">
                <div class="form-floating">
                    <input type="text" name="keyword" class="form-control border-0 bg-light" id="sellerSearch" placeholder="Name or Agency" value="${param.keyword}">
                    <label for="sellerSearch">Search by Name, Agency or Specialization</label>
                </div>
            </div>
            <div class="col-md-3 align-self-center">
                <button type="submit" class="btn btn-premium w-100 py-3 shadow-sm">FIND SELLERS</button>
            </div>
        </form>
    </div>
</div>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-5">
        <h2 class="fw-bold m-0 border-start border-4 border-success ps-3">Professional Directory</h2>
        <c:if test="${sessionScope.user != null && (sessionScope.user.type == 'ADMIN' || sessionScope.user.type == 'admin')}">
            <a href="${pageContext.request.contextPath}/sellers?action=register" class="btn btn-outline-dark rounded-pill px-4 fw-bold">Register Seller</a>
        </c:if>
    </div>

    <div class="row g-4 mb-5">
        <c:forEach var="seller" items="${sellers}">
            <div class="col-lg-3 col-md-6">
                <div class="seller-card shadow-sm">
                    <img src="https://ui-avatars.com/api/?name=${seller.userName}&background=f8f9fa&color=00b98e&size=200" class="seller-avatar" alt="${seller.userName}">
                    
                    <div class="tier-badge bg-light text-dark border">
                        ${seller.userName.length() % 2 == 0 ? 'PLATINUM' : 'GOLD'} PARTNER
                    </div>
                    
                    <h5 class="fw-bold text-dark mb-1">${seller.userName}</h5>
                    <p class="text-emerald small fw-bold mb-3">${seller.agencyName}</p>
                    
                    <div class="mb-4">
                        <span class="badge bg-light text-muted fw-normal rounded-pill px-3 py-2 border">
                            <i class="bi bi-patch-check me-1"></i> ${seller.specialization}
                        </span>
                    </div>

                    <div class="small text-muted mb-3">
                        <i class="bi bi-layers me-1"></i> Portfolio: ${seller.maxListings} Listings Max
                    </div>

                    <div class="d-flex flex-column gap-2 px-3 mb-4">
                        <a href="${pageContext.request.contextPath}/reviews?action=view&targetType=Seller&targetId=${seller.id}" class="btn btn-sm btn-outline-dark rounded-pill">
                            <i class="bi bi-star me-1 text-warning"></i> View Feedbacks
                        </a>
                        <c:if test="${sessionScope.user != null}">
                            <a href="${pageContext.request.contextPath}/reviews?action=submit&targetType=Seller&targetId=${seller.id}" class="btn btn-sm btn-light rounded-pill border">
                                <i class="bi bi-pencil me-1"></i> Write Review
                            </a>
                        </c:if>
                    </div>

                    <c:if test="${sessionScope.user != null && (sessionScope.user.type == 'ADMIN' || sessionScope.user.type == 'admin')}">
                        <div class="d-flex gap-2 justify-content-center border-top pt-3">
                            <a href="${pageContext.request.contextPath}/sellers?action=edit&id=${seller.id}" class="btn btn-sm btn-outline-warning rounded-pill px-3">Edit</a>
                            <form action="${pageContext.request.contextPath}/sellers" method="post" class="d-inline">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${seller.id}">
                                <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill px-3" onclick="return confirm('Deactivate seller access?')">Delete</button>
                            </form>
                        </div>
                    </c:if>
                </div>
            </div>
        </c:forEach>
        
        <c:if test="${empty sellers}">
            <div class="col-12 py-5 text-center">
                <i class="bi bi-people display-1 text-muted opacity-25 mb-4 d-block"></i>
                <h3 class="text-muted fw-bold">No sellers found in results</h3>
                <a href="${pageContext.request.contextPath}/sellers?action=list" class="btn btn-premium mt-3">Reset Directory</a>
            </div>
        </c:if>
    </div>
</div>

<jsp:include page="common/footer.jsp" />

</body>
</html>
