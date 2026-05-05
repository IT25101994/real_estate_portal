<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="common/common-head.jsp" />
    <title>Market Insights | Property Hub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Marcellus&family=Plus+Jakarta+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root { --emerald: #00b98e; --navy: #0a1128; --gold: #c5a059; --bg: #f8f9fa; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background: var(--bg); color: var(--navy); }

        .market-nav { background: white; padding: 12px 40px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; position: sticky; top: 0; z-index: 1000; }
        .brand { font-family: 'Marcellus', serif; font-size: 22px; font-weight: bold; color: var(--navy); text-decoration: none; }
        .brand span { color: var(--emerald); }

        .stats-header { background: var(--navy); color: white; padding: 30px 0 50px; border-bottom-left-radius: 40px; border-bottom-right-radius: 40px; }
        .glass-card { background: white; border-radius: 20px; padding: 20px; border: 1px solid #eee; box-shadow: 0 5px 15px rgba(0,0,0,0.02); height: 100%; }

        .city-pill { border-radius: 12px; font-weight: 700; font-size: 12px; padding: 6px 20px; transition: 0.3s; }
        .city-pill.active { background: var(--emerald) !important; color: white !important; border-color: var(--emerald); }

        /* පින්තූරයේ තිබූ හිස් තැන් පිරවීමට අලුත් Styles */
        .mini-metric { border-left: 3px solid var(--emerald); padding-left: 12px; margin-bottom: 15px; }
        .health-bar { height: 6px; border-radius: 10px; background: #eee; overflow: hidden; margin-top: 5px; }
        .health-fill { height: 100%; background: var(--emerald); }

        .pulse-live { width: 8px; height: 8px; background: #ff5a3c; border-radius: 50%; display: inline-block; animation: pulse 1.5s infinite; margin-right: 5px; }
        @keyframes pulse { 0% { transform: scale(1); opacity: 1; } 70% { transform: scale(2.2); opacity: 0; } 100% { transform: scale(1); opacity: 0; } }
    </style>
</head>
<body>

<nav class="market-nav">
    <a href="${pageContext.request.contextPath}/dashboard" class="brand">PROPERTY<span>HUB</span></a>
    <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline-dark rounded-pill px-4 fw-bold btn-sm shadow-sm">
        <i class="bi bi-house-door me-1"></i> HOME
    </a>
</nav>

<header class="stats-header text-center">
    <div class="container">
        <p class="small text-uppercase fw-bold text-success mb-1" style="letter-spacing: 3px;"><span class="pulse-live"></span> Live Analytics</p>
        <h4 style="font-family: 'Marcellus', serif;">Sri Lanka Property Pulse 2026</h4>
    </div>
</header>

<div class="container" style="margin-top: -35px; padding-bottom: 40px;">
    <div class="row mb-3">
        <div class="col-12 text-center">
            <div class="bg-white d-inline-block p-2 rounded-pill shadow-sm border">
                <button onclick="updatePage('colombo')" id="btn-colombo" class="btn btn-light city-pill active">COLOMBO</button>
                <button onclick="updatePage('kandy')" id="btn-kandy" class="btn btn-light city-pill">KANDY</button>
                <button onclick="updatePage('galle')" id="btn-galle" class="btn btn-light city-pill">GALLE</button>
            </div>
        </div>
    </div>

    <div class="row g-3">
        <div class="col-lg-3">
            <div class="glass-card">
                <h6 class="fw-bold small text-muted mb-3 text-uppercase">Market Summary</h6>

                <div class="mini-metric">
                    <p class="small text-muted mb-0">Avg. Perch Price</p>
                    <h4 class="fw-bold mb-0" id="land-price">Rs. 6.8M</h4>
                </div>

                <div class="mini-metric" style="border-color: var(--navy);">
                    <p class="small text-muted mb-0">Avg. Home Value</p>
                    <h4 class="fw-bold mb-0" id="home-price">Rs. 45.5M</h4>
                </div>

                <div class="mt-4">
                    <div class="d-flex justify-content-between small fw-bold mb-1">
                        <span>Market Health</span>
                        <span class="text-success" id="health-pct">92%</span>
                    </div>
                    <div class="health-bar"><div class="health-fill" id="health-bar-fill" style="width: 92%"></div></div>
                    <p class="x-small text-muted mt-2" style="font-size: 11px;">High demand, low inventory period.</p>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="glass-card">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h6 class="fw-bold m-0 small"><i class="bi bi-activity text-danger me-2"></i>PRICE INDEX</h6>
                    <select class="form-select form-select-sm w-auto border-0 bg-light fw-bold" onchange="toggleGraphType(this.value)">
                        <option value="land">Land Appreciation</option>
                        <option value="home">House Value</option>
                    </select>
                </div>
                <div style="height: 300px;">
                    <canvas id="mainChart"></canvas>
                </div>
            </div>
        </div>

        <div class="col-lg-3">
            <div class="glass-card">
                <h6 class="fw-bold small text-muted mb-3 text-uppercase">District Insights</h6>
                <div id="district-list">
                </div>

                <div class="mt-4 p-3 rounded-3 bg-light border-0 text-center">
                    <i class="bi bi-lightbulb text-warning fs-4"></i>
                    <p class="small fw-bold mt-1 mb-0">Smart Tip</p>
                    <p class="x-small text-muted" id="smart-tip" style="font-size: 11px;">Best time to invest in Colombo suburban lands.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />

<script>
    const marketDb = {
        colombo: {
            l: "Rs. 6.8M", h: "Rs. 45.5M", hp: "92%",
            landData: [40, 42, 45, 48, 52, 55, 60, 65, 70, 75, 78, 85],
            homeData: [30, 31, 33, 35, 38, 40, 42, 45, 48, 50, 52, 55],
            areas: ["Colombo 07", "Nugegoda", "Battaramulla"],
            tip: "Colombo 07 prices are stable; Suburban growth is rising."
        },
        kandy: {
            l: "Rs. 2.4M", h: "Rs. 22.8M", hp: "78%",
            landData: [18, 19, 21, 23, 24, 25, 27, 28, 30, 32, 34, 38],
            homeData: [12, 13, 14, 15, 17, 18, 19, 20, 22, 23, 25, 26],
            areas: ["Peradeniya", "Digana", "Kundasale"],
            tip: "High demand for residential lands near the Expressway link."
        },
        galle: {
            l: "Rs. 3.1M", h: "Rs. 32.5M", hp: "85%",
            landData: [22, 24, 26, 28, 30, 32, 35, 38, 40, 43, 46, 50],
            homeData: [18, 19, 21, 23, 25, 27, 28, 30, 33, 35, 38, 40],
            areas: ["Galle Fort", "Unawatuna", "Hikkaduwa"],
            tip: "Beachfront property values have increased by 15% this year."
        }
    };

    let chart;
    let currentCity = 'colombo';
    let currentType = 'land';

    function initChart() {
        const ctx = document.getElementById('mainChart').getContext('2d');
        chart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
                datasets: [{
                    data: marketDb[currentCity].landData,
                    borderColor: '#00b98e',
                    borderWidth: 3,
                    fill: true,
                    backgroundColor: 'rgba(0, 185, 142, 0.1)',
                    tension: 0.4,
                    pointRadius: 3
                }]
            },
            options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { display: false } } }
        });
    }

    function updatePage(city) {
        currentCity = city;
        document.querySelectorAll('.city-pill').forEach(b => b.classList.remove('active'));
        document.getElementById(`btn-\${city}`).classList.add('active');

        const data = marketDb[city];
        document.getElementById('land-price').innerText = data.l;
        document.getElementById('home-price').innerText = data.h;
        document.getElementById('health-pct').innerText = data.hp;
        document.getElementById('health-bar-fill').style.width = data.hp;
        document.getElementById('smart-tip').innerText = data.tip;

        const list = document.getElementById('district-list');
        list.innerHTML = data.areas.map(a => `<div class="d-flex justify-content-between py-2 border-bottom x-small fw-bold" style="font-size:12px;"><span>\${a}</span><span class="text-success">+2.4%</span></div>`).join('');

        updateGraph();
    }

    function toggleGraphType(type) {
        currentType = type;
        updateGraph();
    }

    function updateGraph() {
        chart.data.datasets[0].data = currentType === 'land' ? marketDb[currentCity].landData : marketDb[currentCity].homeData;
        chart.update();
    }

    window.onload = () => { initChart(); updatePage('colombo'); };
</script>

</body>
</html>
