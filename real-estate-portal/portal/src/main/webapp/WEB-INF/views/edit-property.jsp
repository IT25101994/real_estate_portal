<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="common/common-head.jsp" />
    <title>Edit Property | Property Hub</title>
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
        .current-image-preview {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 20px;
            margin-bottom: 20px;
            border: 1px solid #eee;
        }
    </style>
</head>
<body>

<jsp:include page="common/header.jsp" />

<div class="page-header">
    <div class="container text-center">
        <h1 class="display-5 fw-bold font-marcellus">Modify Listing</h1>
        <p class="opacity-75">Update the details for Property #PRP-${property.id}</p>
    </div>
</div>

<div class="container mb-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="form-card">
                <form action="${pageContext.request.contextPath}/properties?action=update" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="${property.id}">
                    
                    <div class="row g-4">
                        <div class="col-lg-8">
                            <h4 class="fw-bold mb-4">Property Details</h4>
                            <div class="row g-4">
                                <div class="col-12">
                                    <label class="form-label">Property Title</label>
                                    <input type="text" name="title" class="form-control-premium w-100" value="${property.title}" required>
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Location</label>
                                    <input type="text" name="location" class="form-control-premium w-100" value="${property.location}" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Price (LKR)</label>
                                    <input type="number" step="0.01" name="price" class="form-control-premium w-100" value="${property.price}" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Bedrooms</label>
                                    <input type="number" name="bedrooms" class="form-control-premium w-100" value="${property.bedrooms}" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Classification</label>
                                    <select name="type" id="propertyTypeSelect" class="form-select form-control-premium w-100">
                                        <option value="Residential" <c:if test="${property.type == 'Residential'}">selected</c:if>>Residential</option>
                                        <option value="Commercial" <c:if test="${property.type == 'Commercial'}">selected</c:if>>Commercial</option>
                                    </select>
                                </div>
                                <div class="col-md-6 <c:if test="${property.type != 'Commercial'}">d-none</c:if>" id="commercialFields">
                                    <label class="form-label">Business Type</label>
                                    <select name="businessType" class="form-select form-control-premium w-100">
                                        <option value="Office" <c:if test="${property.businessType == 'Office'}">selected</c:if>>Office</option>
                                        <option value="Retail" <c:if test="${property.businessType == 'Retail'}">selected</c:if>>Retail</option>
                                        <option value="Warehouse" <c:if test="${property.businessType == 'Warehouse'}">selected</c:if>>Warehouse</option>
                                        <option value="Industrial" <c:if test="${property.businessType == 'Industrial'}">selected</c:if>>Industrial</option>
                                    </select>
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Listing Status</label>
                                    <select name="status" class="form-select form-control-premium w-100">
                                        <option value="Rented" <c:if test="${property.status == 'Rented'}">selected</c:if>>Rented</option>
                                        <option value="Sold" <c:if test="${property.status == 'Sold'}">selected</c:if>>Sold</option>
                                        <option value="For Rent" <c:if test="${property.status == 'For Rent'}">selected</c:if>>For Rent</option>
                                        <option value="For Sell" <c:if test="${property.status == 'For Sell'}">selected</c:if>>For Sell</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4">
                            <h4 class="fw-bold mb-4">Current Asset</h4>
                            <c:choose>
                                <c:when test="${not empty property.imageUrl}">
                                    <img src="${pageContext.request.contextPath}/${property.imageUrl}" class="current-image-preview" alt="Current Image">
                                </c:when>
                                <c:otherwise>
                                    <img src="https://picsum.photos/seed/sl-home-${property.id}/600/400" class="current-image-preview" alt="Placeholder">
                                </c:otherwise>
                            </c:choose>
                            <label class="form-label">Update Feature Image</label>
                            <input type="file" name="image" class="form-control mb-2" accept="image/*">
                            <p class="small text-muted italic">Leave empty to keep existing.</p>
                        </div>

                        <div class="col-12 mt-4">
                            <label class="form-label">Description</label>
                            <textarea name="description" class="form-control-premium w-100" rows="6" required>${property.description}</textarea>
                        </div>

                        <div class="col-12 text-end mt-5 border-top pt-4">
                            <a href="${pageContext.request.contextPath}/properties?action=list" class="btn btn-link text-decoration-none text-muted me-3">Discard Changes</a>
                            <button type="submit" class="btn btn-premium px-5">SAVE UPDATES</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />
<script>
    document.getElementById('propertyTypeSelect').addEventListener('change', function(e) {
        if (e.target.value === 'Commercial') {
            document.getElementById('commercialFields').classList.remove('d-none');
        } else {
            document.getElementById('commercialFields').classList.add('d-none');
        }
    });
</script>
</body>
</html>
