<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="common/common-head.jsp" />
    <title>Property Hub – Real Estate Portal</title>
    <style>
        .property-card { 
            transition: all 0.4s ease; 
            border-radius: 20px; 
            border: 1px solid var(--border-color); 
            height: 100%; 
            overflow: hidden; 
            background: #fff;
        }
        .property-card:hover { 
            transform: translateY(-10px); 
            box-shadow: 0 20px 40px rgba(0,0,0,0.08); 
        }
        .card-img-wrapper { position: relative; height: 250px; overflow: hidden; }
        .card-img-top { width: 100%; height: 100%; object-fit: cover; transition: transform 0.6s ease; }
        .property-card:hover .card-img-top { transform: scale(1.1); }
        
        .type-badge { 
            position: absolute; top: 20px; left: 20px; 
            padding: 6px 16px; border-radius: 30px; 
            font-weight: 700; z-index: 10; font-size: 0.75rem; 
            text-transform: uppercase; letter-spacing: 1px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
        }
        .price { color: var(--emerald); font-weight: 800; font-size: 1.4rem; }
        
        .search-hero {
            background: var(--dark-navy);
            padding: 100px 0 60px;
            color: white;
            border-bottom-left-radius: 60px;
            margin-bottom: 40px;
        }
    </style>
</head>
<body>

<jsp:include page="common/header.jsp" />

<div class="search-hero">
    <div class="container text-center">
        <h1 class="display-4 fw-bold font-marcellus mb-3">Explore Our Properties</h1>
        <p class="opacity-75 fs-5">Find your perfect match from our curated listings Across Sri Lanka.</p>
    </div>
</div>

<div class="container mb-5">
    <form action="${pageContext.request.contextPath}/properties" method="get" class="luxury-search-small p-4 bg-white shadow-sm rounded-4 border row g-3">
        <input type="hidden" name="action" value="search">
        <div class="col-md-4">
            <div class="form-floating">
                <input type="text" name="keyword" class="form-control border-0 bg-light" id="keyword" placeholder="Colombo" value="${param.keyword}">
                <label for="keyword">Search Keyword or Location</label>
            </div>
        </div>
        <div class="col-md-3">
            <div class="form-floating">
                <select name="type" class="form-select border-0 bg-light" id="type">
                    <option value="">All Types</option>
                    <option value="Residential" <c:if test="${param.type == 'Residential'}">selected</c:if>>Residential</option>
                    <option value="Commercial" <c:if test="${param.type == 'Commercial'}">selected</c:if>>Commercial</option>
                </select>
                <label for="type">Property Type</label>
            </div>
        </div>
        <div class="col-md-3">
            <div class="form-floating">
                <select name="status" class="form-select border-0 bg-light" id="status">
                    <option value="">All Status</option>
                    <option value="Rented" <c:if test="${param.status == 'Rented'}">selected</c:if>>Rented</option>
                    <option value="Sold" <c:if test="${param.status == 'Sold'}">selected</c:if>>Sold</option>
                    <option value="For Rent" <c:if test="${param.status == 'For Rent'}">selected</c:if>>For Rent</option>
                    <option value="For Sell" <c:if test="${param.status == 'For Sell'}">selected</c:if>>For Sell</option>
                </select>
                <label for="status">Availability</label>
            </div>
        </div>
        <div class="col-md-2 align-self-center">
            <button type="submit" class="btn btn-premium w-100 py-3 shadow-sm">SEARCH</button>
        </div>
    </form>
</div>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-5">
        <h2 class="fw-bold m-0 border-start border-4 border-success ps-3">Latest Listings</h2>
        <c:if test="${sessionScope.user != null && sessionScope.user.type != 'BUYER' && sessionScope.user.type != 'buyer'}">
            <a href="${pageContext.request.contextPath}/properties?action=addForm" class="btn btn-outline-dark rounded-pill px-4 fw-bold">+ Add Property</a>
        </c:if>
    </div>

    <div class="row g-4 mb-5">
        <c:forEach var="prop" items="${properties}">
            <div class="col-lg-4 col-md-6">
                <div class="property-card shadow-sm">
                    <div class="card-img-wrapper">
                        <span class="type-badge text-white ${prop.type == 'Commercial' ? 'bg-warning text-dark' : 'bg-success'}">
                            ${prop.type}
                        </span>
                        <c:choose>
                            <c:when test="${not empty prop.imageUrl}">
                                <img src="${pageContext.request.contextPath}/${prop.imageUrl}" class="card-img-top" alt="${prop.title}">
                            </c:when>
                            <c:otherwise>
                                <img src="https://picsum.photos/seed/sl-home-${prop.id}/600/400" class="card-img-top" alt="Placeholder">
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-start mb-2">
                             <h5 class="card-title fw-bold text-truncate m-0" style="max-width: 70%;" title="${prop.title}">
                                ${prop.title}
                            </h5>
                            <span class="badge bg-light text-dark rounded-pill px-3 py-2 small border text-uppercase">${prop.status}</span>
                        </div>
                        
                        <p class="text-muted small mb-3"><i class="bi bi-geo-alt-fill text-danger me-1"></i>${prop.location}</p>

                        <div class="price mb-4">
                            Rs. ${prop.price}
                        </div>

                        <div class="d-grid gap-2">
                            <a href="${pageContext.request.contextPath}/properties?action=detail&id=${prop.id}" class="btn btn-dark rounded-pill py-2 fw-bold">View Details</a>
                            <c:if test="${sessionScope.user != null && (sessionScope.user.type == 'SELLER' || sessionScope.user.type == 'ADMIN' || sessionScope.user.type == 'admin')}">
                                <div class="d-flex gap-2">
                                    <a href="${pageContext.request.contextPath}/properties?action=edit&id=${prop.id}" class="btn btn-sm btn-outline-warning rounded-pill flex-fill"><i class="bi bi-pencil-square"></i> Edit</a>
                                    <form action="${pageContext.request.contextPath}/properties" method="post" class="d-inline flex-fill">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${prop.id}">
                                        <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill w-100" onclick="return confirm('Delete this listing permanently?')"><i class="bi bi-trash"></i> Delete</button>
                                    </form>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        
        <c:if test="${empty properties}">
            <div class="col-12 py-5 text-center">
                <i class="bi bi-search display-1 text-muted opacity-25 mb-4 d-block"></i>
                <h3 class="text-muted fw-bold">No properties match your search</h3>
                <p class="text-muted">Try adjusting your filters or location keyword.</p>
                <a href="${pageContext.request.contextPath}/properties?action=list" class="btn btn-premium mt-3">Reset Search</a>
            </div>
        </c:if>
    </div>
</div>

<jsp:include page="common/footer.jsp" />

</body>
</html>
