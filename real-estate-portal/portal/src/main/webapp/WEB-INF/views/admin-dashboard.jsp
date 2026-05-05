<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="common/common-head.jsp" />
    <title>Admin Dashboard | Property Hub</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .dashboard-header {
            background: var(--dark-navy);
            padding: 80px 0 100px;
            color: white;
            border-bottom-left-radius: 60px;
        }
        .stat-card-premium {
            background: #fff;
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            border: 1px solid #f0f0f0;
            transition: all 0.3s ease;
            height: 100%;
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .stat-card-premium:hover {
            transform: translateY(-5px);
            border-color: var(--emerald);
        }
        .stat-icon-wrap {
            width: 55px; height: 55px; border-radius: 15px;
            display: flex; align-items: center; justify-content: center;
            font-size: 24px;
        }
        .icon-blue { background: rgba(0, 123, 255, 0.1); color: #007bff; }
        .icon-emerald { background: rgba(0, 185, 142, 0.1); color: var(--emerald); }
        .icon-gold { background: rgba(197, 160, 89, 0.1); color: var(--gold); }
        .icon-orange { background: rgba(255, 90, 60, 0.1); color: var(--orange); }

        .dashboard-card {
            background: #fff; border-radius: 25px; padding: 30px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.03); border: 1px solid #f0f0f0;
            height: 100%;
        }
        .card-label { font-size: 0.75rem; font-weight: 700; color: var(--text-muted); text-transform: uppercase; letter-spacing: 1px; margin-bottom: 15px; display: block; }
        
        .recent-table th { font-weight: 700; font-size: 0.7rem; text-transform: uppercase; color: #9aa0ae; border-bottom: 2px solid #f8f9fa; padding-bottom: 15px; }
        .recent-table td { padding: 15px 0; vertical-align: middle; border-bottom: 1px solid #f8f9fa; }
        
        .admin-avatar-small {
            width: 40px; height: 40px; border-radius: 50%;
            background: var(--bg-light); display: flex; align-items: center; justify-content: center;
            font-weight: 700; color: var(--dark-navy); font-size: 0.9rem;
        }
    </style>
</head>
<body>

<jsp:include page="common/header.jsp" />

<div class="dashboard-header">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h1 class="display-5 fw-bold font-marcellus">Executive Overview</h1>
                <p class="opacity-75 mb-0">Platform Governance & Real-Time Performance Metrics</p>
            </div>
            <div class="col-md-4 text-md-end mt-4 mt-md-0">
                <div class="d-inline-flex align-items-center bg-white bg-opacity-10 rounded-pill px-4 py-2">
                    <div class="admin-avatar-small me-3" style="background: var(--emerald); color: white;">A</div>
                    <div class="text-start">
                        <div class="fw-bold small">System Administrator</div>
                        <div class="small opacity-50">v2.4.0 Patch Active</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container" style="margin-top: -50px; position: relative; z-index: 10;">
    <!-- Quick Stats -->
    <div class="row g-4 mb-5">
        <div class="col-lg-3 col-md-6">
            <div class="stat-card-premium">
                <div class="stat-icon-wrap icon-blue"><i class="bi bi-people"></i></div>
                <div>
                    <div class="stat-label text-muted small fw-bold">TOTAL USERS</div>
                    <h3 class="fw-bold mb-0">${userCount != null ? userCount : '1,280'}</h3>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6">
            <div class="stat-card-premium">
                <div class="stat-icon-wrap icon-emerald"><i class="bi bi-building"></i></div>
                <div>
                    <div class="stat-label text-muted small fw-bold">TOTAL ASSETS</div>
                    <h3 class="fw-bold mb-0">${propertyCount != null ? propertyCount : '452'}</h3>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6">
            <div class="stat-card-premium">
                <div class="stat-icon-wrap icon-gold"><i class="bi bi-chat-dots"></i></div>
                <div>
                    <div class="stat-label text-muted small fw-bold">INQUIRIES</div>
                    <h3 class="fw-bold mb-0">${inquiryCount != null ? inquiryCount : '86'}</h3>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6">
            <div class="stat-card-premium">
                <div class="stat-icon-wrap icon-orange"><i class="bi bi-star"></i></div>
                <div>
                    <div class="stat-label text-muted small fw-bold">REVIEWS</div>
                    <h3 class="fw-bold mb-0">${reviewCount != null ? reviewCount : '312'}</h3>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Charts Section -->
    <div class="row g-4 mb-5">
        <div class="col-lg-8">
            <div class="dashboard-card">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h5 class="fw-bold m-0">Inventory Dynamics</h5>
                    <select class="form-select form-select-sm border-0 bg-light rounded-pill px-3" style="width: 150px;">
                        <option>Last 30 Days</option>
                        <option>Last 6 Months</option>
                    </select>
                </div>
                <div style="height: 300px;">
                    <canvas id="inventoryChart"></canvas>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="dashboard-card">
                <h5 class="fw-bold mb-4">Inquiry Distribution</h5>
                <div style="height: 250px; position: relative;">
                    <canvas id="distributionChart"></canvas>
                    <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); text-align: center; pointer-events: none;">
                        <div class="display-6 fw-bold">${inquiryCount != null ? inquiryCount : '86'}</div>
                        <div class="small text-muted fw-bold">TOTAL</div>
                    </div>
                </div>
                <div class="mt-4 pt-3 border-top">
                    <div class="d-flex justify-content-between mb-2">
                        <span class="small text-muted"><i class="bi bi-circle-fill text-emerald me-2"></i> Pending</span>
                        <span class="small fw-bold">${inquiryStats[0] != null ? inquiryStats[0] : '24'}</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="small text-muted"><i class="bi bi-circle-fill text-primary me-2"></i> Responded</span>
                        <span class="small fw-bold">${inquiryStats[1] != null ? inquiryStats[1] : '42'}</span>
                    </div>
                    <div class="d-flex justify-content-between">
                        <span class="small text-muted"><i class="bi bi-circle-fill text-gold me-2"></i> Resolved</span>
                        <span class="small fw-bold">${inquiryStats[2] != null ? inquiryStats[2] : '20'}</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Secondary Grids -->
    <div class="row g-4 mb-5">
        <div class="col-lg-7">
            <div class="dashboard-card">
                <h5 class="fw-bold mb-4">Recent Asset Acquisitions</h5>
                <div class="table-responsive">
                    <table class="table recent-table mb-0">
                        <thead>
                            <tr>
                                <th>ASSET</th>
                                <th>VALUATION</th>
                                <th>LOCATION</th>
                                <th>STATUS</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="prop" items="${recentProperties}" end="4">
                                <tr>
                                    <td>
                                        <div class="fw-bold text-dark">${prop.title}</div>
                                        <div class="small text-muted">${prop.type}</div>
                                    </td>
                                    <td><span class="fw-bold">Rs. ${prop.price}</span></td>
                                    <td><span class="badge bg-light text-muted border">${prop.location}</span></td>
                                    <td><span class="badge bg-emerald bg-opacity-10 text-emerald">Active</span></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty recentProperties}">
                                <c:forEach var="i" begin="1" end="3">
                                    <tr>
                                        <td>
                                            <div class="fw-bold text-dark">Sample Estate ${i}</div>
                                            <div class="small text-muted">Apartment</div>
                                        </td>
                                        <td><span class="fw-bold">Rs. 125,000</span></td>
                                        <td><span class="badge bg-light text-muted border">Colombo 07</span></td>
                                        <td><span class="badge bg-emerald bg-opacity-10 text-emerald">Active</span></td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="col-lg-5">
            <div class="dashboard-card">
                <h5 class="fw-bold mb-4">Platform Oversight</h5>
                <div class="list-group list-group-flush">
                    <c:forEach var="admin" items="${recentAdmins}" end="4">
                        <div class="list-group-item px-0 py-3 d-flex align-items-center justify-content-between border-0 border-bottom">
                            <div class="d-flex align-items-center">
                                <div class="admin-avatar-small me-3">
                                    ${admin.name.substring(0, 1).toUpperCase()}
                                </div>
                                <div>
                                    <div class="fw-bold text-dark">${admin.name}</div>
                                    <div class="small text-muted">${admin.role}</div>
                                </div>
                            </div>
                            <button class="btn btn-light btn-sm rounded-pill shadow-sm">View Profile</button>
                        </div>
                    </c:forEach>
                    <c:if test="${empty recentAdmins}">
                        <div class="py-4 text-center text-muted">No recent administrative activity.</div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />

<script>
    // Inventory Dynamics (Line Chart)
    const invCtx = document.getElementById('inventoryChart').getContext('2d');
    const invGradient = invCtx.createLinearGradient(0, 0, 0, 300);
    invGradient.addColorStop(0, 'rgba(0, 185, 142, 0.1)');
    invGradient.addColorStop(1, 'rgba(0, 185, 142, 0)');

    new Chart(invCtx, {
        type: 'line',
        data: {
            labels: ['Day 3', 'Day 6', 'Day 9', 'Day 12', 'Day 15', 'Day 18', 'Day 21', 'Day 24', 'Day 27', 'Day 30'],
            datasets: [{
                data: ${not empty propertyGrowthData ? propertyGrowthData : '[65, 82, 95, 120, 145, 170, 205, 240, 290, 312]'},
                borderColor: '#00b98e',
                backgroundColor: invGradient,
                fill: true,
                tension: 0.4,
                borderWidth: 3,
                pointRadius: 0
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { display: false } },
            scales: {
                y: { grid: { display: false }, ticks: { display: false } },
                x: { grid: { color: '#f8f9fa' } }
            }
        }
    });

    // Distribution (Doughnut Chart)
    new Chart(document.getElementById('distributionChart').getContext('2d'), {
        type: 'doughnut',
        data: {
            labels: ['Pending', 'Responded', 'Resolved'],
            datasets: [{
                data: [
                    ${inquiryStats[0] != null ? inquiryStats[0] : 24},
                    ${inquiryStats[1] != null ? inquiryStats[1] : 42},
                    ${inquiryStats[2] != null ? inquiryStats[2] : 20}
                ],
                backgroundColor: ['#00b98e', '#007bff', '#c5a059'],
                borderWidth: 0,
                hoverOffset: 15
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            cutout: '85%',
            plugins: { legend: { display: false } }
        }
    });
</script>

</body>
</html>