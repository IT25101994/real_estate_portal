<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="common/common-head.jsp" />
    <title>Send Inquiry | Property Hub</title>
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
        <h1 class="display-5 fw-bold font-marcellus">Concierge Inquiry</h1>
        <p class="opacity-75">Manually log or dispatch a property inquiry for a specific client.</p>
    </div>
</div>

<div class="container mb-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="form-card">
                <form action="${pageContext.request.contextPath}/inquiries" method="post">
                    <input type="hidden" name="action" value="send">
                    
                    <div class="row g-4">
                        <div class="col-12">
                            <label class="form-label">Client / Buyer Account</label>
                            <select name="buyerId" class="form-select form-control-premium w-100" required>
                                <option value="" selected disabled>-- Select a Registered User --</option>
                                <c:forEach var="user" items="${users}">
                                    <option value="${user.id}">${user.name} (${user.email})</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-12">
                            <label class="form-label">Property Asset</label>
                            <select name="propertyId" class="form-select form-control-premium w-100" required>
                                <option value="" selected disabled>-- Select a Listed Property --</option>
                                <c:forEach var="prop" items="${properties}">
                                    <option value="${prop.id}">${prop.title} | ${prop.location} [#ID-${prop.id}]</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-12">
                            <label class="form-label">Priority / Urgency Status</label>
                            <select name="urgencyLevel" class="form-select form-control-premium w-100">
                                <option value="Low">Low - Standard Inquiry</option>
                                <option value="Medium" selected>Medium - Active Interest</option>
                                <option value="High">High - Urgent Acquisition</option>
                            </select>
                        </div>

                        <div class="col-12">
                            <label class="form-label">Message Details</label>
                            <textarea name="message" class="form-control-premium w-100" rows="5" required placeholder="Describe the specific interest or questions from the client..."></textarea>
                        </div>

                        <div class="col-12 text-end mt-5 border-top pt-4">
                            <a href="${pageContext.request.contextPath}/inquiries?action=list" class="btn btn-link text-decoration-none text-muted me-3">Discard</a>
                            <button type="submit" class="btn btn-premium px-5">DISPATCH INQUIRY</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />

</body>
</html>
