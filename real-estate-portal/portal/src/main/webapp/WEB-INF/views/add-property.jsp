<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="common/common-head.jsp" />
    <title>Post Property | Property Hub</title>
    <style>
        .page-header {
            background: var(--dark-navy);
            padding: 100px 0 80px;
            color: white;
            border-bottom-left-radius: 60px;
        }
        .form-card {
            background: #fff;
            border-radius: 30px;
            padding: 50px;
            box-shadow: 0 40px 100px rgba(0,0,0,0.08);
            border: 1px solid #f0f0f0;
            margin-top: -60px;
            position: relative;
            z-index: 20;
        }
        .form-label {
            font-weight: 700;
            font-size: 0.85rem;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 10px;
        }
        .form-control-premium {
            background: #f8f9fa;
            border: 1px solid transparent;
            border-radius: 12px;
            padding: 12px 20px;
            font-weight: 500;
            transition: all 0.3s;
        }
        .form-control-premium:focus {
            background: #fff;
            border-color: var(--emerald);
            box-shadow: 0 0 0 4px rgba(0, 185, 142, 0.1);
            outline: none;
        }
    </style>
</head>
<body>

<jsp:include page="common/header.jsp" />

<div class="page-header">
    <div class="container text-center">
        <h1 class="display-5 fw-bold font-marcellus">List Your Property</h1>
        <p class="opacity-75">Connect with thousands of potential buyers in Sri Lanka.</p>
    </div>
</div>

<div class="container mb-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="form-card">
                <form action="${pageContext.request.contextPath}/properties?action=add" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="sellerId" value="${sessionScope.user.id}">
                    
                    <div class="row g-4">
                        <div class="col-12">
                            <h4 class="fw-bold mb-3">Basic Information</h4>
                        </div>
                        
                        <div class="col-md-8">
                            <label class="form-label">Property Title / Attraction</label>
                            <input type="text" name="title" class="form-control-premium w-100" placeholder="e.g. Modern Villa with Sea View" required>
                        </div>
                        
                        <div class="col-md-4">
                            <label class="form-label">Location / City</label>
                            <input type="text" name="location" class="form-control-premium w-100" placeholder="e.g. Colombo 07" required>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Price (LKR)</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-0" style="border-radius: 12px 0 0 12px;">Rs.</span>
                                <input type="number" step="0.01" name="price" class="form-control-premium border-0" style="border-radius: 0 12px 12px 0; flex:1;" required>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Bedrooms / Units</label>
                            <input type="number" name="bedrooms" class="form-control-premium w-100" required>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Classification</label>
                            <select name="type" class="form-select form-control-premium w-100">
                                <option value="Residential">Residential</option>
                                <option value="Commercial">Commercial</option>
                            </select>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Current Status</label>
                            <select name="status" class="form-select form-control-premium w-100">
                                <option value="Rented">Rented</option>
                                <option value="Sold">Sold</option>
                                <option value="For Rent">For Rent</option>
                                <option value="For Sell">For Sell</option>
                            </select>
                        </div>

                        <div class="col-md-8 d-none" id="commercialFields">
                            <label class="form-label">Business / Commercial Spec</label>
                            <input type="text" name="businessType" class="form-control-premium w-100" placeholder="e.g. Retail, Office Space">
                        </div>

                        <div class="col-12 mt-4 pt-4 border-top">
                            <h4 class="fw-bold mb-3">Media & Description</h4>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Primary Property Image (Cover)</label>
                            <div class="p-4 border border-dashed rounded-4 text-center bg-light">
                                <input type="file" name="image" class="form-control mb-2" accept="image/*" required>
                                <p class="small text-muted mb-0">Cover photo for the listing. Max size 5MB.</p>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Property Gallery (Viewers can see)</label>
                            <div class="p-4 border border-dashed rounded-4 text-center bg-light">
                                <input type="file" name="gallery" class="form-control mb-2" accept="image/*" multiple>
                                <p class="small text-muted mb-0">Select multiple photos for the detailed view.</p>
                            </div>
                        </div>

                        <div class="col-12">
                            <label class="form-label">Detailed Description</label>
                            <textarea name="description" class="form-control-premium w-100" rows="5" placeholder="Share the key features, amenities, and selling points of this property..." required></textarea>
                        </div>

                        <div class="col-12 text-end mt-5">
                            <a href="${pageContext.request.contextPath}/properties?action=list" class="btn btn-link text-decoration-none text-muted me-3">Cancel</a>
                            <button type="submit" class="btn btn-premium px-5">POST PROPERTY</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />

<script>
    document.querySelector('select[name="type"]').addEventListener('change', function(e) {
        if (e.target.value === 'Commercial') {
            document.getElementById('commercialFields').classList.remove('d-none');
        } else {
            document.getElementById('commercialFields').classList.add('d-none');
        }
    });
</script>

</body>
</html>
