<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="common/common-head.jsp" />
    <title>Review Moderation | Property Hub</title>
    <style>
        .page-header {
            background: var(--dark-navy);
            padding: 100px 0 80px;
            color: white;
            border-bottom-left-radius: 60px;
        }
        .moderation-card {
            background: #fff;
            border-radius: 20px;
            border: 1px solid var(--border-color);
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            padding: 30px;
            margin-top: -50px;
            position: relative;
            z-index: 10;
        }
        .table thead th {
            background: #f8f9fa;
            border-bottom: 2px solid #eee;
            color: var(--text-muted);
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 1px;
            padding: 15px;
        }
        .table tbody td {
            padding: 20px 15px;
            vertical-align: middle;
            font-size: 0.9rem;
        }
        .star-rating {
            color: #ffc107;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>

<jsp:include page="common/header.jsp" />

<div class="page-header">
    <div class="container text-center">
        <h1 class="display-5 fw-bold font-marcellus">Review Moderation</h1>
        <p class="opacity-75">Maintain the integrity of platform feedback and ratings.</p>
    </div>
</div>

<div class="container mb-5">
    <div class="moderation-card">
        <c:if test="${not empty param.msg}">
            <div class="alert alert-success alert-dismissible fade show rounded-4 mb-4" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i>
                <c:choose>
                    <c:when test="${param.msg == 'submitted'}">Review published successfully.</c:when>
                    <c:when test="${param.msg == 'updated'}">Review updated successfully.</c:when>
                    <c:when test="${param.msg == 'deleted'}">Review removed successfully.</c:when>
                </c:choose>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h4 class="fw-bold m-0">Recent Feedback</h4>
            <a href="${pageContext.request.contextPath}/reviews?action=submit" class="btn btn-premium btn-sm">ADD REVIEW MANUALLY</a>
        </div>

        <div class="table-responsive">
            <table class="table hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Target Identity</th>
                        <th>Rating Metrics</th>
                        <th>Feedback Transcript</th>
                        <th class="text-end">Moderation</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="review" items="${reviews}">
                        <tr>
                            <td class="fw-bold text-muted">#REV-${review.id}</td>
                            <td class="d-flex align-items-center gap-3">
                                <c:choose>
                                    <c:when test="${not empty review.userPhoto}">
                                        <img src="${pageContext.request.contextPath}/${review.userPhoto}" class="rounded-circle shadow-sm" style="width: 40px; height: 40px; object-fit: cover;">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="rounded-circle bg-light d-flex align-items-center justify-content-center fw-bold text-success border" style="width: 40px; height: 40px;">${not empty review.userName ? review.userName.substring(0,1).toUpperCase() : 'U'}</div>
                                    </c:otherwise>
                                </c:choose>
                                <div>
                                    <div class="fw-bold text-dark">${review.targetLabel}</div>
                                    <div class="small text-muted">Ref: ${review.targetType} (#${review.targetId})</div>
                                </div>
                            </td>
                            <td>
                                <div class="star-rating mb-1">${review.stars}</div>
                                <div class="small fw-bold text-dark">${review.rating}/5.0</div>
                            </td>
                            <td>
                                <div class="text-muted italic small" style="max-width: 300px;">"${review.comment}"</div>
                            </td>
                            <td class="text-end">
                                <a href="${pageContext.request.contextPath}/reviews?action=view&targetType=${review.targetType}&targetId=${review.targetId}" class="btn btn-sm btn-outline-dark rounded-pill px-3 me-1">View Thread</a>
                                <form action="${pageContext.request.contextPath}/reviews" method="post" class="d-inline">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${review.id}">
                                    <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill px-3" onclick="return confirm('Delete this review completely?')">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty reviews}">
                        <tr>
                            <td colspan="5" class="text-center py-5 text-muted">
                                <i class="bi bi-star display-4 opacity-25 d-block mb-3"></i>
                                No reviews have been submitted yet.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />

</body>
</html>
