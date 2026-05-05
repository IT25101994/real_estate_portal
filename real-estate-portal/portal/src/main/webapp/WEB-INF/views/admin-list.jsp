<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="common/common-head.jsp" />
    <title>Admin Directory | Property Hub</title>
    <style>
        .page-header {
            background: var(--dark-navy);
            padding: 100px 0 80px;
            color: white;
            border-bottom-left-radius: 60px;
        }
        .management-card {
            background: #fff; border-radius: 20px; border: 1px solid var(--border-color);
            box-shadow: 0 10px 30px rgba(0,0,0,0.05); padding: 30px;
            margin-top: -50px; position: relative; z-index: 10;
        }
        .table thead th {
            background: #f8f9fa; border-bottom: 2px solid #eee;
            color: var(--text-muted); text-transform: uppercase;
            font-size: 0.75rem; letter-spacing: 1px; padding: 15px;
        }
        .table tbody td { padding: 20px 15px; vertical-align: middle; font-size: 0.9rem; }
        .permission-badge {
            font-size: 0.7rem; font-weight: 700; padding: 4px 10px; border-radius: 6px;
            text-transform: uppercase; margin-right: 4px;
        }
        .perm-granted { background: rgba(0, 185, 142, 0.1); color: var(--emerald); }
        .perm-denied { background: rgba(220, 53, 69, 0.1); color: #dc3545; }
    </style>
</head>
<body>

<jsp:include page="common/header.jsp" />

<div class="page-header">
    <div class="container text-center">
        <h1 class="display-5 fw-bold font-marcellus">Administrative Oversight</h1>
        <p class="opacity-75">Manage the internal team and platform governance roles.</p>
    </div>
</div>

<div class="container mb-5">
    <div class="management-card">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h4 class="fw-bold m-0">System Administrators</h4>
            <a href="${pageContext.request.contextPath}/admins?action=register" class="btn btn-premium btn-sm">ADD NEW ADMIN</a>
        </div>

        <div class="table-responsive">
            <table class="table hover">
                <thead>
                    <tr>
                        <th>Access ID</th>
                        <th>Administrator info</th>
                        <th>Role tier</th>
                        <th>Permission profile</th>
                        <th class="text-end">Management</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="admin" items="${admins}">
                        <tr>
                            <td class="fw-bold text-muted">#ADM-${admin.id}</td>
                            <td class="d-flex align-items-center gap-3">
                                <c:choose>
                                    <c:when test="${not empty admin.profilePhoto}">
                                        <img src="${pageContext.request.contextPath}/${admin.profilePhoto}" class="rounded-circle shadow-sm" style="width: 40px; height: 40px; object-fit: cover;">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="rounded-circle bg-light d-flex align-items-center justify-content-center fw-bold text-success border" style="width: 40px; height: 40px;">${admin.name.substring(0,1).toUpperCase()}</div>
                                    </c:otherwise>
                                </c:choose>
                                <div>
                                    <div class="fw-bold text-dark">${admin.name}</div>
                                    <div class="small text-muted">${admin.email}</div>
                                </div>
                            </td>
                            <td>
                                <span class="badge bg-light text-dark border text-uppercase" style="font-size: 0.7rem;">${admin.role}</span>
                            </td>
                            <td>
                                <div class="d-flex flex-wrap gap-2">
                                    <span class="permission-badge ${admin.canDeleteUsers ? 'perm-granted' : 'perm-denied'}">
                                        <i class="bi bi-${admin.canDeleteUsers ? 'check' : 'x'}-circle me-1"></i> User Removal
                                    </span>
                                    <span class="permission-badge ${admin.canManageAdmins ? 'perm-granted' : 'perm-denied'}">
                                        <i class="bi bi-${admin.canManageAdmins ? 'check' : 'x'}-circle me-1"></i> Admin Ctrl
                                    </span>
                                </div>
                            </td>
                            <td class="text-end">
                                <form action="${pageContext.request.contextPath}/admins" method="post" class="d-inline">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${admin.id}">
                                    <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill px-3" 
                                            onclick="return confirm('Revoke admin privileges?')" 
                                            <c:if test="${sessionScope.user.type != 'ADMIN' && sessionScope.user.type != 'admin'}">disabled</c:if>>
                                        Delete
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty admins}">
                        <tr>
                            <td colspan="5" class="text-center py-5 text-muted">
                                <i class="bi bi-shield-lock display-4 opacity-25 d-block mb-3"></i>
                                No administrative records found.
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
