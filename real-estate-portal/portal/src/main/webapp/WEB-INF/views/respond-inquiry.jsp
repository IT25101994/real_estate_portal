<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="common/common-head.jsp" />
    <title>Respond to Inquiry | Property Hub</title>
    <style>
        .page-header {
            background: var(--dark-navy);
            padding: 100px 0 80px;
            color: white;
            border-bottom-left-radius: 60px;
        }
        .form-card {
            background: #fff; border-radius: 30px; padding: 40px;
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
        .message-box {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 25px;
            border-left: 5px solid var(--emerald);
            margin-bottom: 30px;
            position: relative;
        }
        .message-box::after {
            content: 'Inquiry Content';
            position: absolute;
            top: -10px;
            left: 20px;
            background: var(--emerald);
            color: white;
            padding: 2px 12px;
            font-size: 0.65rem;
            font-weight: 800;
            border-radius: 20px;
            text-transform: uppercase;
        }
    </style>
</head>
<body>

<jsp:include page="common/header.jsp" />

<div class="page-header">
    <div class="container text-center">
        <h1 class="display-5 fw-bold font-marcellus">Resolution Portal</h1>
        <p class="opacity-75">Review and respond to Inquiry #INQ-${inquiry.id}</p>
    </div>
</div>

<div class="container mb-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="form-card">
                <div class="message-box">
                    <p class="mb-0 text-dark fw-medium fs-5 italic">"${inquiry.message}"</p>
                </div>

                <form action="${pageContext.request.contextPath}/inquiries" method="post">
                    <input type="hidden" name="action" value="respond">
                    <input type="hidden" name="id" value="${inquiry.id}">
                    
                    <div class="row g-4">
                        <div class="col-12">
                            <label class="form-label">Update Case Status</label>
                            <select name="status" class="form-select form-control-premium w-100">
                                <option value="Pending" <c:if test="${inquiry.status == 'Pending'}">selected</c:if>>Keep as Pending</option>
                                <option value="Responded" <c:if test="${inquiry.status == 'Responded'}">selected</c:if>>Mark as Responded</option>
                                <option value="Closed" <c:if test="${inquiry.status == 'Closed'}">selected</c:if>>Close Inquiry</option>
                            </select>
                        </div>

                        <div class="col-12">
                            <label class="form-label">Professional Response / Advisor Notes</label>
                            <textarea name="response" class="form-control-premium w-100" rows="6" placeholder="Draft your detailed response to the client here..." required>${inquiry.response}</textarea>
                        </div>

                        <div class="col-12 text-end mt-5 border-top pt-4">
                            <a href="${pageContext.request.contextPath}/inquiries?action=list" class="btn btn-link text-decoration-none text-muted me-3">Back to List</a>
                            <button type="submit" class="btn btn-premium px-5">UPATE & SEND RESPONSE</button>
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
