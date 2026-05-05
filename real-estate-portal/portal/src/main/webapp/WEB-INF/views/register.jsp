<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="common/common-head.jsp" />
    <title>User Registration | Property Hub</title>
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
        <h1 class="display-5 fw-bold font-marcellus">Join Property Hub</h1>
        <p class="opacity-75">Create your account to start listing or searching for properties.</p>
    </div>
</div>

<div class="container mb-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="form-card">
                <form action="${pageContext.request.contextPath}/users/register" method="post">
                    <div class="row g-4">
                        <div class="col-12">
                            <label class="form-label">Full Name</label>
                            <input type="text" name="name" class="form-control-premium w-100" placeholder="e.g. Kamal Perera" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Email Address</label>
                            <input type="email" name="email" class="form-control-premium w-100" placeholder="name@example.com" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Password</label>
                            <input type="password" name="password" class="form-control-premium w-100" placeholder="••••••••" required>
                        </div>

                        <div class="col-12">
                            <label class="form-label">I am a...</label>
                            <select name="type" class="form-select form-control-premium w-100">
                                <option value="BUYER">Home Buyer / Tenant</option>
                                <option value="SELLER">Real Estate Seller</option>
                            </select>
                        </div>

                        <div class="col-12 text-center mt-5">
                            <button type="submit" class="btn btn-premium px-5 w-100 mb-3">CREATE ACCOUNT</button>
                            <p class="small text-muted mb-0">Already have an account? <a href="${pageContext.request.contextPath}/dashboard" class="text-emerald fw-bold">Sign In</a></p>
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
