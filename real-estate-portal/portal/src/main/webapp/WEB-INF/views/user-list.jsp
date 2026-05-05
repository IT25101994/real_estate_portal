<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="common/common-head.jsp" />
    <title>User Directory | Property Hub</title>
    <style>
        .page-header {
            background: var(--dark-navy);
            padding: 100px 0 80px;
            color: white;
            border-bottom-left-radius: 60px;
        }
        .management-card {
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
        .user-type-badge {
            padding: 6px 14px;
            border-radius: 30px;
            font-weight: 700;
            font-size: 0.75rem;
            text-transform: uppercase;
        }
        .search-bar-rounded {
            background: #f1f3f5;
            border-radius: 30px;
            padding: 10px 20px;
            border: 1px solid transparent;
            transition: all 0.3s;
        }
        .search-bar-rounded:focus {
            background: #fff;
            border-color: var(--emerald);
            box-shadow: 0 0 0 3px rgba(0, 185, 142, 0.1);
            outline: none;
        }
    </style>
</head>
<body>

<jsp:include page="common/header.jsp" />

<div class="page-header">
    <div class="container text-center">
        <h1 class="display-5 fw-bold font-marcellus">User Directory</h1>
        <p class="opacity-75">Overview and management of all registered platform members.</p>
    </div>
</div>

<div class="container mb-5">
    <div class="management-card">
        <div class="row align-items-center mb-4">
            <div class="col-lg-4">
                <h4 class="fw-bold m-0">Platform Members</h4>
            </div>
            <div class="col-lg-5">
                <form action="${pageContext.request.contextPath}/users" method="get" class="d-flex">
                    <input type="hidden" name="action" value="search">
                    <div class="input-group">
                        <input type="text" name="keyword" class="search-bar-rounded w-100" placeholder="Search name or email..." value="${param.keyword}">
                    </div>
                </form>
            </div>
            <div class="col-lg-3 text-end">
                <a href="${pageContext.request.contextPath}/users?action=registerForm" class="btn btn-premium btn-sm">ADD NEW USER</a>
            </div>
        </div>

        <c:if test="${not empty param.msg}">
            <div class="alert alert-success alert-dismissible fade show rounded-3" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> ${param.msg}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <div class="table-responsive">
            <table class="table hover">
                <thead>
                    <tr>
                        <th>Access ID</th>
                        <th>Member Identity</th>
                        <th>Classification</th>
                        <th>Profile Snippet</th>
                        <th class="text-end">Management</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td class="fw-bold text-muted">#${user.id}</td>
                            <td class="d-flex align-items-center gap-3">
                                <c:choose>
                                    <c:when test="${not empty user.profilePhoto}">
                                        <img src="${pageContext.request.contextPath}/${user.profilePhoto}" class="rounded-circle shadow-sm" style="width: 40px; height: 40px; object-fit: cover;">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="rounded-circle bg-light d-flex align-items-center justify-content-center fw-bold text-success border" style="width: 40px; height: 40px;">${user.name.substring(0,1).toUpperCase()}</div>
                                    </c:otherwise>
                                </c:choose>
                                <div>
                                    <div class="fw-bold text-dark">${user.name}</div>
                                    <div class="small text-muted">${user.email}</div>
                                </div>
                            </td>
                            <td>
                                <span class="user-type-badge bg-light text-dark border">
                                    ${user.type}
                                </span>
                            </td>
                            <td>
                                <div class="small text-muted italic">${user.welcomeMessage}</div>
                            </td>
                            <td class="text-end">
                                <a href="${pageContext.request.contextPath}/users?action=edit&id=${user.id}" class="btn btn-sm btn-outline-warning rounded-pill px-3 me-1">Edit</a>
                                <form action="${pageContext.request.contextPath}/users" method="post" class="d-inline">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${user.id}">
                                    <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill px-3" onclick="return confirm('Archive this user account?')">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty users}">
                        <tr>
                            <td colspan="5" class="text-center py-5 text-muted">
                                <i class="bi bi-people display-4 opacity-25 d-block mb-3"></i>
                                No users found in the registry.
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
