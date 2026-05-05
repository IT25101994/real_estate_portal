<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="common/common-head.jsp" />
    <title>Submit Review | Property Hub</title>
    <style>
        .page-header {
            background: var(--dark-navy);
            padding: 100px 0 80px;
            color: white;
            border-bottom-left-radius: 60px;
        }
        .form-card {
            background: #fff; border-radius: 30px; padding: 50px;
            box-shadow: 0 40px 100px rgba(0,0,0,0.08); border: 1px solid #f0f0f0;
            margin-top: -60px; position: relative; z-index: 20;
        }
        .form-label { font-weight: 700; font-size: 0.85rem; color: var(--text-muted); text-transform: uppercase; margin-bottom: 10px; }
        .form-control-premium {
            background: #f8f9fa; border: 1px solid transparent; border-radius: 12px;
            padding: 12px 20px; font-weight: 500; transition: all 0.3s;
        }
        .form-control-premium:focus {
            background: #fff; border-color: var(--emerald);
            box-shadow: 0 0 0 4px rgba(0, 185, 142, 0.1); outline: none;
        }
    </style>
</head>
<body>

<jsp:include page="common/header.jsp" />

<div class="page-header">
    <div class="container text-center">
        <h1 class="display-5 fw-bold font-marcellus">Quality Feedback</h1>
        <p class="opacity-75">Share your experience to help our community make better decisions.</p>
    </div>
</div>

<div class="container mb-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="form-card">
                <c:if test="${not empty param.error}">
                    <div class="alert alert-danger mb-4 rounded-4" style="font-size: 0.9rem;">
                        <i class="bi bi-exclamation-triangle me-2"></i> ${param.error}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/reviews" method="post">
                    <input type="hidden" name="action" value="submit">
                    
                    <div class="row g-4">
                        <div class="col-md-6">
                            <label class="form-label">Feedback Category</label>
                            <select name="targetType" class="form-select form-control-premium w-100">
                                <option value="property" ${targetType == 'property' ? 'selected' : ''}>Property Performance</option>
                                <option value="seller" ${targetType == 'seller' ? 'selected' : ''}>Professional Conduct</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Reference ID (Asset or Member)</label>
                            <input type="number" name="targetId" class="form-control-premium w-100" value="${targetId}" placeholder="e.g. 104" required>
                        </div>

                        <div class="col-md-6 ${(sessionScope.user.type == 'ADMIN' || sessionScope.user.type == 'admin') ? '' : 'd-none'}">
                            <label class="form-label">Review Author ID</label>
                            <input type="number" name="userId" class="form-control-premium w-100" value="${sessionScope.user.id}" placeholder="Your user ID" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Overall Rating</label>
                            <select name="rating" class="form-select form-control-premium w-100" required>
                                <option value="5" selected>⭐⭐⭐⭐⭐ - Exceptional</option>
                                <option value="4">⭐⭐⭐⭐ - Very Good</option>
                                <option value="3">⭐⭐⭐ - Satisfactory</option>
                                <option value="2">⭐⭐ - Below Average</option>
                                <option value="1">⭐ - Unsatisfactory</option>
                            </select>
                        </div>

                        <div class="col-12" id="propertySpecific">
                            <label class="form-label">Location Excellence (1-5)</label>
                            <input type="range" name="locationRating" class="form-range" min="1" max="5" step="1" value="3">
                            <div class="d-flex justify-content-between small text-muted">
                                <span>Poor</span>
                                <span>Excellent</span>
                            </div>
                        </div>
                        
                        <div class="col-12 d-none" id="sellerSpecific">
                            <label class="form-label">Communication & Clarity (1-5)</label>
                            <input type="range" name="communicationRating" class="form-range" min="1" max="5" step="1" value="3">
                            <div class="d-flex justify-content-between small text-muted">
                                <span>Poor</span>
                                <span>Excellent</span>
                            </div>
                        </div>

                        <div class="col-12">
                            <label class="form-label">Detailed Testimony</label>
                            <textarea name="comment" class="form-control-premium w-100" rows="5" placeholder="Elaborate on your experience, noting specific pros and cons..." required></textarea>
                        </div>

                        <div class="col-12 text-end mt-5 border-top pt-4">
                            <a href="${pageContext.request.contextPath}/reviews?action=list" class="btn btn-link text-decoration-none text-muted me-3">Discard</a>
                            <button type="submit" class="btn btn-premium px-5">PUBLISH REVIEW</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />

<script>
    document.querySelector('select[name="targetType"]').addEventListener('change', function(e) {
        if (e.target.value === 'Property') {
            document.getElementById('propertySpecific').classList.remove('d-none');
            document.getElementById('sellerSpecific').classList.add('d-none');
        } else {
            document.getElementById('propertySpecific').classList.add('d-none');
            document.getElementById('sellerSpecific').classList.remove('d-none');
        }
    });
</script>

</body>
</html>
