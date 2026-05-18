<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="common/common-head.jsp" />
    <title>My Account | Property Hub</title>
    <style>
        .page-header {
            background: var(--dark-navy);
            padding: 100px 0 80px;
            color: white;
            border-bottom-left-radius: 60px;
        }
        .profile-container {
            background: #fff;
            border-radius: 20px;
            border: 1px solid var(--border-color);
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            padding: 40px;
            margin-top: -60px;
            position: relative;
            z-index: 10;
        }
        .avatar-preview {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--emerald), var(--dark-navy));
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            font-weight: 700;
            margin: 0 auto 20px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
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
        .profile-sidebar {
            border-right: 1px solid #eee;
        }
    </style>
</head>
<body>

<jsp:include page="common/header.jsp" />

<div class="page-header">
    <div class="container text-center">
        <h1 class="display-5 fw-bold font-marcellus">Personal Settings</h1>
        <p class="opacity-75">Update your contact information and platform preferences.</p>
    </div>
</div>

<div class="container mb-5">
    <div class="profile-container">
        <c:if test="${param.msg == 'updated'}">
            <div class="alert alert-success alert-dismissible fade show rounded-4 mb-4" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> Your profile has been updated successfully.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${param.msg == 'welcome'}">
            <div class="alert alert-primary alert-dismissible fade show rounded-4 mb-4" role="alert">
                <i class="bi bi-stars me-2"></i> Welcome to Property Hub! Let's complete your profile.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${param.msg == 'supervisor_connected'}">
            <div class="alert alert-success alert-dismissible fade show rounded-4 mb-4" role="alert">
                <i class="bi bi-link-45deg me-2"></i> Successfully connected with the senior supervisor!
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${param.msg == 'seller_promoted'}">
            <div class="alert alert-success alert-dismissible fade show rounded-4 mb-4" role="alert">
                <i class="bi bi-award-fill me-2"></i> Junior seller has been successfully promoted to Senior Seller!
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <div class="row g-5">
            <div class="col-lg-4 text-center profile-sidebar">
                <div class="avatar-preview">
                    <c:choose>
                        <c:when test="${not empty userProfile.profilePhoto}">
                            <img src="${pageContext.request.contextPath}/${userProfile.profilePhoto}" class="w-100 h-100 rounded-circle shadow-sm" style="object-fit: cover;">
                        </c:when>
                        <c:otherwise>
                            ${userProfile.name.substring(0, 1).toUpperCase()}
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <form action="${pageContext.request.contextPath}/profile/upload-photo" method="POST" enctype="multipart/form-data" class="mb-4">
                    <input type="file" name="photo" id="profilePhotoInput" class="d-none" accept="image/*" onchange="this.form.submit()">
                    <button type="button" class="btn btn-outline-success btn-sm rounded-pill px-3" onclick="document.getElementById('profilePhotoInput').click()">
                        <i class="bi bi-camera me-1"></i> Change Photo
                    </button>
                </form>

                <h3 class="fw-bold m-0">${userProfile.name}</h3>
                <p class="text-emerald fw-bold small text-uppercase mb-4">
                    <c:choose>
                        <c:when test="${not empty sellerDetails}">
                            ${sellerDetails.tier.toUpperCase()} SELLER
                        </c:when>
                        <c:otherwise>
                            ${userProfile.type}
                        </c:otherwise>
                    </c:choose>
                </p>
                <hr>
                <div class="text-start mt-4 px-3">
                    <p class="small text-muted mb-2"><i class="bi bi-calendar-check me-2"></i> Joined: <span class="text-dark">${userProfile.createdAt}</span></p>
                    <p class="small text-muted mb-4"><i class="bi bi-shield-lock me-2"></i> Security: <span class="text-dark">Active</span></p>
                </div>
                <c:if test="${not empty sellerDetails}">
                    <hr>
                    <div class="text-center mt-3">
                        <h6 class="fw-bold text-uppercase text-muted small mb-3">Seller Tier Status</h6>
                        <span class="badge ${sellerDetails.tierBadge} fs-6 py-2 px-4 rounded-pill my-2 border">
                            ${sellerDetails.tier.toUpperCase()} SELLER
                        </span>
                        <div class="mt-3 text-muted small">
                            <i class="bi bi-info-circle me-1"></i> Max Listings: <strong class="text-dark">${sellerDetails.maxListings}</strong>
                        </div>
                    </div>
                </c:if>
            </div>

            <div class="col-lg-8">
                <h4 class="fw-bold mb-4">Edit Information</h4>
                <form action="${pageContext.request.contextPath}/profile/update" method="POST">
                    <input type="hidden" name="id" value="${userProfile.id}"/>
                    
                    <div class="row g-4">
                        <div class="col-md-6">
                            <label class="form-label">Full Account Name</label>
                            <input type="text" name="name" class="form-control-premium w-100" value="${userProfile.name}" required/>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Email Primary Address</label>
                            <input type="email" name="email" class="form-control-premium w-100" value="${userProfile.email}" required/>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Contact Phone Number</label>
                            <input type="text" name="phone" class="form-control-premium w-100" value="${not empty sellerDetails ? sellerDetails.contactPhone : userProfile.phone}" placeholder="+1 (234) 567-890"/>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">New Password (Optional)</label>
                            <input type="password" name="password" class="form-control-premium w-100" placeholder="Type to change..."/>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Physical Mailing Address</label>
                            <input type="text" name="address" class="form-control-premium w-100" value="${not empty sellerDetails ? sellerDetails.mailingAddress : userProfile.address}" placeholder="Street, City, Postal Code"/>
                        </div>
                        
                        <c:if test="${not empty sellerDetails}">
                            <div class="col-md-4">
                                <label class="form-label">Real Estate License Number</label>
                                <input type="text" name="licenseNumber" class="form-control-premium w-100" value="${sellerDetails.licenseNumber}" required/>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Agency Name</label>
                                <input type="text" name="agencyName" class="form-control-premium w-100" value="${sellerDetails.agencyName}" required/>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Specialization</label>
                                <input type="text" name="specialization" class="form-control-premium w-100" value="${sellerDetails.specialization}" required/>
                            </div>
                        </c:if>

                        <div class="col-12">
                            <label class="form-label">Personal Biography</label>
                            <textarea name="bio" class="form-control-premium w-100" rows="4" placeholder="Tell us about yourself...">${not empty sellerDetails ? sellerDetails.personalBiography : userProfile.bio}</textarea>
                        </div>
                        <div class="col-12 text-end mt-5">
                            <button type="submit" class="btn btn-premium px-5">UPDATE PROFILE</button>
                        </div>
                    </div>
                </form>
                
                <c:if test="${not empty sellerDetails}">
                    <div class="border-top pt-5 mt-5">
                        <h4 class="fw-bold mb-3 text-dark"><i class="bi bi-patch-check-fill me-2 text-emerald"></i>Professional Tier Certification</h4>
                        <div class="bg-light p-4 rounded-4 border">
                            <div class="row align-items-center">
                                <div class="col-md-7">
                                    <span class="text-muted small d-block">CURRENT PROFESSIONAL TIER:</span>
                                    <strong class="text-success fs-4 d-flex align-items-center gap-2 mt-1">
                                        <i class="bi bi-award-fill text-warning"></i>
                                        <span class="badge ${sellerDetails.tierBadge} fs-6 px-3 py-2 rounded-pill">${sellerDetails.tier.toUpperCase()} SELLER</span>
                                    </strong>
                                    <p class="text-muted small mt-3 mb-0">
                                        <i class="bi bi-shield-lock-fill me-1 text-secondary"></i>
                                        <strong>Administration Policy:</strong> Only system administrators are authorized to change or upgrade a seller's tier. If you require a status change (e.g. from Junior to Senior), please contact support.
                                    </p>
                                </div>
                                <div class="col-md-5 text-md-end mt-3 mt-md-0">
                                    <div class="bg-white p-3 rounded-3 border d-inline-block text-start shadow-sm">
                                        <span class="text-muted small d-block">ACCOUNT LIMITATIONS:</span>
                                        <div class="mt-2 text-dark font-premium">
                                            <i class="bi bi-house-check-fill text-emerald me-2"></i>Max Listings: <strong>${sellerDetails.maxListings}</strong>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />

</body>
</html>
