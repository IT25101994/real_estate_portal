<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="common/common-head.jsp" />
    <title>Inquiries | Property Hub</title>
    <style>
        .table-card {
            background: #fff;
            border-radius: 20px;
            border: 1px solid var(--border-color);
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            padding: 30px;
            margin-top: -50px;
            position: relative;
            z-index: 10;
        }
        .page-header {
            background: var(--dark-navy);
            padding: 100px 0 80px;
            color: white;
            border-bottom-left-radius: 60px;
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
        .status-badge {
            padding: 6px 14px;
            border-radius: 30px;
            font-weight: 700;
            font-size: 0.75rem;
            text-transform: uppercase;
        }
    </style>
</head>
<body>

<jsp:include page="common/header.jsp" />

<div class="page-header">
    <div class="container text-center">
        <h1 class="display-5 fw-bold font-marcellus">Message Center</h1>
        <p class="opacity-75">Manage your property inquiries and client communications.</p>
    </div>
</div>

<div class="container mb-5">
    <div class="table-card">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h4 class="fw-bold m-0">Global Inquiries</h4>
            <a href="${pageContext.request.contextPath}/inquiries?action=send" class="btn btn-premium btn-sm">SEND NEW INQUIRY</a>
        </div>

        <div class="table-responsive">
            <table class="table hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Property Reference</th>
                        <th>Sender info</th>
                        <th>Inquiry Message</th>
                        <th>Status</th>
                        <th class="text-end">Management</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="inquiry" items="${inquiries}">
                        <tr>
                            <td class="fw-bold text-muted">${inquiry.id}</td>
                            <td>
                                <div class="fw-bold text-dark">${inquiry.propertyTitle}</div>
                                <div class="small text-muted">ID: ${inquiry.propertyId}</div>
                            </td>
                            <td>
                                <div class="small fw-bold">User #${inquiry.buyerId}</div>
                            </td>
                            <td>
                                <div class="text-truncate" style="max-width: 250px;" title="${inquiry.message}">${inquiry.message}</div>
                            </td>
                            <td>
                                <span class="status-badge ${inquiry.statusBadgeClass}">${inquiry.statusLabel}</span>
                            </td>
                            <td class="text-end">
                                <a href="${pageContext.request.contextPath}/inquiries?action=respond&id=${inquiry.id}" class="btn btn-sm btn-outline-success rounded-pill px-3 me-1">Respond</a>
                                <form action="${pageContext.request.contextPath}/inquiries" method="post" class="d-inline">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${inquiry.id}">
                                    <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill px-3" onclick="return confirm('Delete this inquiry?')">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty inquiries}">
                        <tr>
                            <td colspan="6" class="text-center py-5 text-muted">
                                <i class="bi bi-chat-left-text display-4 opacity-25 d-block mb-3"></i>
                                No active inquiries found in the system.
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
