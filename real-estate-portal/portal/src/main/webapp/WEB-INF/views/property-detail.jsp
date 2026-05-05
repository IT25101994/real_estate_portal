<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="common/common-head.jsp" />
    <title>${property.title} | Property Hub</title>
    <style>
        .hero-banner {
            position: relative;
            height: 60vh;
            min-height: 500px;
            background-size: cover;
            background-position: center;
            border-bottom-left-radius: 80px;
            overflow: hidden;
        }
        .hero-overlay {
            position: absolute; top:0; left:0; right:0; bottom:0;
            background: linear-gradient(to bottom, rgba(10,17,40,0.2) 0%, rgba(10,17,40,0.8) 100%);
            display: flex; flex-direction: column; justify-content: flex-end; padding: 60px;
            color: white;
        }
        .detail-container {
            margin-top: -100px;
            position: relative;
            z-index: 20;
        }
        .main-card {
            background: white; border-radius: 30px; padding: 50px;
            box-shadow: 0 40px 100px rgba(0,0,0,0.08); border: 1px solid #f0f0f0;
        }
        .price-display {
            font-size: 3rem; font-weight: 800; color: var(--emerald); font-family: 'Plus Jakarta Sans', sans-serif;
        }
        .feature-item {
            background: #fcfbf8; border-radius: 20px; padding: 25px; text-align: center; border: 1px solid #f5f5f5; transition: 0.3s;
        }
        .feature-item:hover { transform: translateY(-5px); border-color: var(--emerald); }
        .feature-item i { font-size: 2.5rem; color: var(--gold); margin-bottom: 15px; display: block; }
        .feature-item .val { font-size: 1.5rem; font-weight: 700; color: var(--dark-navy); }
        .feature-item .lbl { font-size: 0.75rem; text-transform: uppercase; font-weight: 800; color: #999; letter-spacing: 1px; }

        .seller-widget {
            background: var(--dark-navy); color: white; border-radius: 30px; padding: 40px; text-align: center;
            top: 20px; position: sticky; box-shadow: 0 20px 50px rgba(10,17,40,0.2);
        }
        .seller-avatar {
            width: 120px; height: 120px; border-radius: 50%; border: 5px solid rgba(255,255,255,0.1); margin-bottom: 20px; object-fit: cover;
        }
        .contact-btn {
            background: var(--emerald); color: white; border: none; padding: 15px 30px; border-radius: 15px; width: 100%; font-weight: 700; transition: 0.3s;
        }
        .contact-btn:hover { background: #008f6d; transform: scale(1.02); }
        
        .description-box { font-size: 1.1rem; line-height: 1.9; color: #444; }
    </style>
</head>
<body>

<jsp:include page="common/header.jsp" />

<div class="hero-banner">
    <c:choose>
        <c:when test="${not empty property.imageUrl}">
            <img src="${pageContext.request.contextPath}/${property.imageUrl}" style="position:absolute; width:100%; height:100%; object-fit:cover;" alt="Hero">
        </c:when>
        <c:otherwise>
            <img src="https://picsum.photos/seed/sl-home-${property.id}/1920/1080" style="position:absolute; width:100%; height:100%; object-fit:cover;" alt="Hero">
        </c:otherwise>
    </c:choose>
    <div class="hero-overlay">
        <div class="container">
            <span class="badge bg-gold text-white px-3 py-2 rounded-pill mb-3 text-uppercase fw-bold shadow" style="background:var(--gold)">${property.type}</span>
            <h1 class="display-3 fw-bold font-marcellus mb-2">${property.title}</h1>
            <p class="fs-4 fw-light opacity-75 mb-0"><i class="bi bi-geo-alt-fill text-danger me-2"></i>${property.location}</p>
        </div>
    </div>
</div>

<div class="container detail-container pb-5">
    <div class="row g-5">
        <div class="col-lg-8">
            <div class="main-card">
                <div class="d-flex justify-content-between align-items-end mb-5 border-bottom pb-4">
                    <div>
                        <p class="small text-uppercase fw-bold text-muted mb-1">Asking Price</p>
                        <div class="price-display">Rs. ${property.price}</div>
                    </div>
                    <div class="text-end">
                        <span class="badge bg-success px-4 py-2 rounded-pill fs-6 text-uppercase fw-bold shadow-sm">${property.status}</span>
                        <p class="small text-muted mt-2 mb-0">Ref ID: #PRP-${property.id}</p>
                    </div>
                </div>

                <div class="row g-4 mb-5">
                    <div class="col-md-4">
                        <div class="feature-item">
                            <i class="bi bi-door-open-fill"></i>
                            <div class="val">${property.bedrooms}</div>
                            <div class="lbl">Bedrooms</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="feature-item">
                            <i class="bi bi-calendar-check-fill"></i>
                            <div class="val">${property.createdAt != null ? property.createdAt.substring(0, 10) : 'Recent'}</div>
                            <div class="lbl">Listing Date</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="feature-item">
                            <i class="bi bi-patch-check-fill"></i>
                            <div class="val">Verified</div>
                            <div class="lbl">Status</div>
                        </div>
                    </div>
                </div>

                <h3 class="fw-bold font-marcellus mb-4 border-start border-4 border-success ps-3">Property Description</h3>
                <div class="description-box mb-5">
                    ${property.description}
                </div>

                <c:if test="${not empty property.galleryImages}">
                    <h5 class="fw-bold mb-4 font-marcellus">Interior & Exterior Photos</h5>
                    <div class="row g-3 mb-5">
                        <c:forEach var="gal" items="${property.galleryImages}">
                            <div class="col-md-4 col-6">
                                <div class="rounded-4 overflow-hidden border shadow-sm h-100" style="aspect-ratio: 4/3;">
                                    <img src="${pageContext.request.contextPath}/${gal}" class="w-100 h-100 object-fit-cover hover-zoom" 
                                         style="transition: 0.5s; cursor: pointer;" onclick="window.open(this.src)" alt="Gallery">
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>

                <div class="mt-5 pt-4 border-top">
                    <h5 class="fw-bold mb-3">Location Insights</h5>
                    <p class="text-muted">Situated in the heart of ${property.location}, this property offers easy access to major schools, hospitals, and transportation hubs. Experience luxury living in a prime neighborhood.</p>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="seller-widget">
                <c:choose>
                    <c:when test="${not empty property.sellerPhoto}">
                        <img src="${pageContext.request.contextPath}/${property.sellerPhoto}" class="seller-avatar" alt="Seller">
                    </c:when>
                    <c:otherwise>
                        <img src="https://ui-avatars.com/api/?name=${property.sellerName}&background=c5a059&color=fff" class="seller-avatar" alt="Seller">
                    </c:otherwise>
                </c:choose>
                <h4 class="fw-bold mb-1">${property.sellerName}</h4>
                <p class="text-emerald small fw-bold text-uppercase mb-4">Certified Listing Seller</p>
                
                <form action="${pageContext.request.contextPath}/inquiries" method="get" class="mb-2">
                    <input type="hidden" name="action" value="send">
                    <input type="hidden" name="propertyId" value="${property.id}">
                    <button type="submit" class="contact-btn rounded-pill"><i class="bi bi-chat-dots-fill me-2"></i>Send Inquiry</button>
                </form>

                <div class="d-grid gap-2 mb-3">
                    <a href="${pageContext.request.contextPath}/reviews?action=view&targetType=Property&targetId=${property.id}" class="btn btn-outline-light rounded-pill fw-bold">
                        <i class="bi bi-star-fill me-2 text-warning"></i>View Reviews
                    </a>
                    <c:if test="${sessionScope.user != null}">
                        <a href="${pageContext.request.contextPath}/reviews?action=submit&targetType=Property&targetId=${property.id}" class="btn btn-dark rounded-pill fw-bold" style="border: 1px solid rgba(255,255,255,0.2);">
                            <i class="bi bi-pencil-square me-2"></i>Write a Review
                        </a>
                    </c:if>
                </div>

                <div class="d-flex gap-2 justify-content-center mt-4">
                    <div class="bg-white bg-opacity-10 p-2 rounded-circle border border-white border-opacity-10" style="width: 40px; height:40px;"><i class="bi bi-telephone"></i></div>
                    <div class="bg-white bg-opacity-10 p-2 rounded-circle border border-white border-opacity-10" style="width: 40px; height:40px;"><i class="bi bi-whatsapp"></i></div>
                </div>

                <c:if test="${sessionScope.user != null && (sessionScope.user.type == 'SELLER' || sessionScope.user.type == 'ADMIN' || sessionScope.user.type == 'admin')}">
                    <div class="mt-5 pt-4 border-top border-white border-opacity-10">
                        <p class="small text-white-50 mb-3 text-uppercase fw-bold">Management Tools</p>
                        <div class="d-flex gap-2">
                            <a href="${pageContext.request.contextPath}/properties?action=edit&id=${property.id}" class="btn btn-outline-light rounded-pill flex-fill fw-bold">Edit</a>
                            <form action="${pageContext.request.contextPath}/properties" method="post" class="flex-fill">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${property.id}">
                                <button type="submit" class="btn btn-outline-danger rounded-pill w-100 fw-bold" onclick="return confirm('Permanently remove listing?')">Delete</button>
                            </form>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />

</body>
</html>
