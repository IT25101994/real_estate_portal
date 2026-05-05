<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="common/common-head.jsp" />
    <title>Edit User | Property Hub</title>
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
        <h1 class="display-5 fw-bold font-marcellus">Modify Member Profile</h1>
        <p class="opacity-75">Update the security and identity settings for Member #${user.id}</p>
    </div>
</div>

<div class="container mb-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="form-card">
                <form action="${pageContext.request.contextPath}/users" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="${user.id}">
                    
                    <div class="row g-4">
                        <div class="col-12">
                            <label class="form-label">Full Name</label>
                            <input type="text" name="name" class="form-control-premium w-100" value="${user.name}" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Registered Email</label>
                            <input type="email" name="email" class="form-control-premium w-100" value="${user.email}" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Membership Class</label>
                            <select name="type" class="form-select form-control-premium w-100">
                                <option value="buyer" ${user.type == 'buyer' ? 'selected' : ''}>Home Buyer / Tenant</option>
                                <option value="seller" ${user.type == 'seller' ? 'selected' : ''}>Real Estate Seller</option>
                            </select>
                        </div>

                        <div class="col-12">
                            <label class="form-label">Security Overhaul <small class="text-muted">(Leave as-is to keep password)</small></label>
                            <input type="password" name="password" class="form-control-premium w-100" placeholder="New Secret Credential (Optional)">
                        </div>

                        <div class="col-12 text-end mt-5 border-top pt-4">
                            <a href="${pageContext.request.contextPath}/users?action=list" class="btn btn-link text-decoration-none text-muted me-3">Cancel & Return</a>
                            <button type="submit" class="btn btn-premium px-5">UPDATE MEMBER</button>
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