<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<footer class="footer">
    <div class="footer-container">
        <!-- Brand & Mission Column -->
        <div class="footer-col brand-col">
            <div class="footer-logo">
                <span class="logo-icon"><i class="fa-solid fa-bag-shopping"></i></span>
                <span class="logo-text">Fashion<span class="logo-accent">Store</span></span>
            </div>
            <p class="brand-desc">
                Elevating your personal style with curated luxury collections. Designed for modern life, crafted with exceptional quality and uncompromising ethics.
            </p>
            <div class="social-links">
                <a href="#" class="social-btn" aria-label="Facebook"><i class="fa-brands fa-facebook-f"></i></a>
                <a href="#" class="social-btn" aria-label="Instagram"><i class="fa-brands fa-instagram"></i></a>
                <a href="#" class="social-btn" aria-label="Twitter"><i class="fa-brands fa-x-twitter"></i></a>
                <a href="#" class="social-btn" aria-label="Pinterest"><i class="fa-brands fa-pinterest-p"></i></a>
            </div>
        </div>

        <!-- Shop Categories -->
        <div class="footer-col">
            <h4 class="col-title">Shop Collections</h4>
            <ul class="footer-links">
                <li><a href="${pageContext.request.contextPath}/products?category=1">Men's Apparel</a></li>
                <li><a href="${pageContext.request.contextPath}/products?category=2">Women's Collection</a></li>
                <li><a href="${pageContext.request.contextPath}/products?category=3">Kids & Teens</a></li>
                <li><a href="${pageContext.request.contextPath}/products?category=4">Footwear & Sneakers</a></li>
                <li><a href="${pageContext.request.contextPath}/products?category=5">Luxury Watches</a></li>
            </ul>
        </div>

        <!-- Quick Links -->
        <div class="footer-col">
            <h4 class="col-title">Quick Links</h4>
            <ul class="footer-links">
                <li><a href="${pageContext.request.contextPath}/home">Home Page</a></li>
                <li><a href="${pageContext.request.contextPath}/products">All Products</a></li>
                <li><a href="${pageContext.request.contextPath}/cart">My Shopping Cart</a></li>
                <li><a href="${pageContext.request.contextPath}/orders">Order Tracking</a></li>
                <li><a href="${pageContext.request.contextPath}/profile">My Account</a></li>
            </ul>
        </div>

        <!-- Customer Care & Contact -->
        <div class="footer-col">
            <h4 class="col-title">Customer Care</h4>
            <ul class="footer-contact-list">
                <li>
                    <i class="fa-solid fa-envelope"></i>
                    <span>support@fashionstore.com</span>
                </li>
                <li>
                    <i class="fa-solid fa-phone"></i>
                    <span>+91 98765 43210</span>
                </li>
                <li>
                    <i class="fa-solid fa-location-dot"></i>
                    <span>Fashion Hub, Bangalore, India</span>
                </li>
                <li>
                    <i class="fa-solid fa-shield-halved"></i>
                    <span>100% Secure Checkout</span>
                </li>
            </ul>
        </div>
    </div>

    <!-- Bottom Copyright & Badges -->
    <div class="footer-bottom">
        <div class="footer-bottom-inner">
            <p>&copy; <%= java.time.Year.now().getValue() %> FashionStore Inc. All rights reserved. Built with Java Servlets, JSP & MySQL.</p>
            <div class="payment-methods-icons">
                <span title="Visa"><i class="fa-brands fa-cc-visa"></i></span>
                <span title="Mastercard"><i class="fa-brands fa-cc-mastercard"></i></span>
                <span title="UPI"><i class="fa-solid fa-qrcode"></i></span>
                <span title="Cash On Delivery"><i class="fa-solid fa-money-bill-wave"></i></span>
            </div>
        </div>
    </div>
</footer>

<style>
/* =========================================================
   LUXE NEUMORPHIC FOOTER STYLES
   ========================================================= */
.footer {
    background: var(--color-surface);
    margin-top: 60px;
    padding-top: 60px;
    box-shadow: 0 -6px 20px rgba(0, 0, 0, 0.03);
    border-top: 1px solid var(--color-border);
    transition: var(--transition);
}

.footer-container {
    width: 92%;
    max-width: 1240px;
    margin: 0 auto;
    display: grid;
    grid-template-columns: 2fr 1fr 1fr 1.5fr;
    gap: 40px;
    padding-bottom: 50px;
}

.footer-logo {
    display: flex;
    align-items: center;
    gap: 10px;
    font-size: 20px;
    font-weight: 800;
    color: var(--color-primary);
    margin-bottom: 16px;
}

.brand-desc {
    color: var(--color-secondary);
    font-size: 14px;
    line-height: 1.7;
    margin-bottom: 22px;
    max-width: 320px;
}

.social-links {
    display: flex;
    gap: 12px;
}

.social-btn {
    width: 38px;
    height: 38px;
    border-radius: 50%;
    background: var(--color-surface);
    box-shadow: var(--nm-flat-sm);
    display: flex;
    align-items: center;
    justify-content: center;
    color: var(--color-secondary);
    font-size: 14px;
    transition: var(--transition);
}

.social-btn:hover {
    color: var(--color-accent);
    box-shadow: var(--nm-hover);
    transform: translateY(-2px);
}

.social-btn:active {
    box-shadow: var(--nm-inset-sm);
}

.col-title {
    font-size: 16px;
    font-weight: 700;
    color: var(--color-primary);
    margin-bottom: 20px;
    position: relative;
    padding-bottom: 8px;
}

.col-title::after {
    content: '';
    position: absolute;
    left: 0;
    bottom: 0;
    width: 28px;
    height: 3px;
    background: var(--color-accent);
    border-radius: var(--radius-pill);
}

.footer-links {
    list-style: none;
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.footer-links a {
    color: var(--color-secondary);
    font-size: 14px;
    transition: var(--transition);
}

.footer-links a:hover {
    color: var(--color-accent);
    padding-left: 6px;
}

.footer-contact-list {
    list-style: none;
    display: flex;
    flex-direction: column;
    gap: 14px;
}

.footer-contact-list li {
    display: flex;
    align-items: center;
    gap: 12px;
    color: var(--color-secondary);
    font-size: 14px;
}

.footer-contact-list li i {
    color: var(--color-accent);
    font-size: 15px;
    width: 18px;
    text-align: center;
}

.footer-bottom {
    border-top: 1px solid var(--color-border);
    padding: 24px 0;
    background: rgba(0, 0, 0, 0.02);
}

.footer-bottom-inner {
    width: 92%;
    max-width: 1240px;
    margin: 0 auto;
    display: flex;
    align-items: center;
    justify-content: space-between;
    flex-wrap: wrap;
    gap: 16px;
}

.footer-bottom p {
    font-size: 13px;
    color: var(--color-secondary);
}

.payment-methods-icons {
    display: flex;
    gap: 14px;
    font-size: 24px;
    color: var(--color-secondary);
}

.payment-methods-icons span:hover {
    color: var(--color-accent);
}

@media (max-width: 992px) {
    .footer-container {
        grid-template-columns: 1fr 1fr;
    }
}

@media (max-width: 576px) {
    .footer-container {
        grid-template-columns: 1fr;
        gap: 30px;
    }
    .footer-bottom-inner {
        flex-direction: column;
        text-align: center;
    }
}
</style>