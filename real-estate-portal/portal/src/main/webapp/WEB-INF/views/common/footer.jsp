<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    footer { background: #f8f9fa; padding: 80px 0 30px; border-top: 1px solid #eee; margin-top: 50px; }
    footer .brand { font-size: 22px; font-weight: bold; color: var(--dark-navy); }
    .footer-link { color: #666; text-decoration: none; transition: 0.3s; font-size: 14px; }
    .footer-link:hover { color: var(--emerald); }
    .social-icons a { color: var(--text-muted); font-size: 18px; transition: 0.3s; }
    .social-icons a:hover { color: var(--emerald); }
</style>

<footer>
    <div class="container">
        <div class="row g-5 text-start">
            <div class="col-lg-4">
                <a href="${pageContext.request.contextPath}/dashboard" class="brand mb-3 d-block text-decoration-none">PROPERTY<span>HUB</span></a>
                <p class="text-muted small lh-lg">Sri Lanka's most trusted real estate partner. Whether you're looking for a luxury villa or a prime piece of land, we've got you covered.</p>
                <div class="mt-4">
                    <h6 class="fw-bold small text-uppercase mb-3">Office Location</h6>
                    <p class="text-muted small"><i class="bi bi-geo-alt-fill text-success me-2"></i> No 123, Luxury Plaza, Colombo 07, Sri Lanka.</p>
                </div>
            </div>

            <div class="col-lg-2 col-md-4">
                <h6 class="fw-bold mb-4">Quick Links</h6>
                <div class="d-flex flex-column gap-2">
                    <a href="${pageContext.request.contextPath}/privacy-policy" class="footer-link">Privacy Policy</a>
                    <a href="${pageContext.request.contextPath}/terms-of-service" class="footer-link">Terms of Service</a>
                    <a href="${pageContext.request.contextPath}/support-center" class="footer-link">Support Center</a>
                    <a href="${pageContext.request.contextPath}/contact-us" class="footer-link">Contact Us</a>
                </div>
            </div>

            <div class="col-lg-3 col-md-4">
                <h6 class="fw-bold mb-4">Direct Contact</h6>
                <div class="d-flex align-items-center mb-4">
                    <div class="bg-white shadow-sm rounded-3 p-3 me-3 text-success fs-4"><i class="bi bi-telephone"></i></div>
                    <div>
                        <p class="mb-0 small fw-bold">Customer Hotline</p>
                        <p class="mb-0 small text-muted">+94 771 234 567</p>
                    </div>
                </div>
                <div class="d-flex align-items-center">
                    <div class="bg-white shadow-sm rounded-3 p-3 me-3 text-success fs-4"><i class="bi bi-envelope"></i></div>
                    <div>
                        <p class="mb-0 small fw-bold">Sales Email</p>
                        <p class="mb-0 small text-muted">sales@propertyhub.lk</p>
                    </div>
                </div>
            </div>

            <div class="col-lg-3 col-md-4">
                <h6 class="fw-bold mb-4">Newsletter</h6>
                <p class="text-muted small">Stay updated with our newest properties.</p>
                <div class="input-group mb-3">
                    <input type="email" class="form-control border-0 shadow-sm" style="border-radius: 10px 0 0 10px;" placeholder="Your Email">
                    <button class="btn btn-success" style="border-radius: 0 10px 10px 0;"><i class="bi bi-send-fill"></i></button>
                </div>
                <div class="social-icons d-flex gap-3">
                    <a href="#"><i class="bi bi-facebook"></i></a>
                    <a href="#"><i class="bi bi-instagram"></i></a>
                    <a href="#"><i class="bi bi-twitter-x"></i></a>
                    <a href="#"><i class="bi bi-linkedin"></i></a>
                </div>
            </div>
        </div>
        <hr class="my-5 opacity-25">
        <div class="text-center">
            <p class="text-muted small mb-0">&copy; 2026 Property Hub (Pvt) Ltd. All Rights Reserved. | <a href="${pageContext.request.contextPath}/privacy-policy" class="text-decoration-none text-muted">Privacy Policy</a> | <a href="${pageContext.request.contextPath}/terms-of-service" class="text-decoration-none text-muted">Terms of Service</a></p>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
