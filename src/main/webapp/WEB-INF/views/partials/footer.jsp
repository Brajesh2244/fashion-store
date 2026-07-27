<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<footer class="footer">

    <div class="footer-container">

        <div class="footer-section">

            <h2>FashionStore</h2>

            <p style="margin-bottom: 20px;">
                Elevating your personal style with premium curated fashion collections. Quality products designed for modern life.
            </p>
            
            <div class="social-icons" style="display: flex; gap: 15px; font-size: 18px; margin-top: 15px;">
                <a href="#" style="color: #9ca3af; transition: 0.3s;"><i class="fab fa-facebook-f"></i></a>
                <a href="#" style="color: #9ca3af; transition: 0.3s;"><i class="fab fa-instagram"></i></a>
                <a href="#" style="color: #9ca3af; transition: 0.3s;"><i class="fab fa-twitter"></i></a>
                <a href="#" style="color: #9ca3af; transition: 0.3s;"><i class="fab fa-pinterest"></i></a>
            </div>

        </div>

        <div class="footer-section">

            <h3>Quick Links</h3>

            <ul style="padding: 0;">

                <li><a href="${pageContext.request.contextPath}/home">Home</a></li>

                <li><a href="${pageContext.request.contextPath}/products">Products</a></li>

                <li><a href="${pageContext.request.contextPath}/cart">Cart</a></li>

                <li><a href="${pageContext.request.contextPath}/orders">Orders</a></li>

            </ul>

        </div>

        <div class="footer-section">

            <h3>Customer Support</h3>

            <ul style="padding: 0;">

                <li style="color: #9ca3af;">Email: support@fashionstore.com</li>

                <li style="color: #9ca3af;">Phone: +91 9876543210</li>

                <li style="color: #9ca3af;">Bengaluru, India</li>

            </ul>

        </div>

    </div>

    <div class="footer-bottom">

        <p>
            © 2026 FashionStore. All Rights Reserved. Designed with elegance.
        </p>

    </div>

</footer>

<script>
window.addEventListener('scroll', function() {
    const navbar = document.querySelector('.navbar');
    if (navbar) {
        if (window.scrollY > 20) {
            navbar.classList.add('navbar-solid');
        } else {
            navbar.classList.remove('navbar-solid');
        }
    }
});

document.addEventListener('DOMContentLoaded', function() {
    const navbar = document.querySelector('.navbar');
    if (navbar) {
        if (window.scrollY > 20) {
            navbar.classList.add('navbar-solid');
        } else {
            navbar.classList.remove('navbar-solid');
        }
    }
});
</script>