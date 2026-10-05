<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.fashionstore.model.User"%>
<%@ page import="com.fashionstore.dao.impl.CartDAOImpl"%>
<%@ page import="com.fashionstore.dao.impl.CartItemDAOImpl"%>
<%@ page import="com.fashionstore.model.Cart"%>

<%
User loggedInUser = (User) session.getAttribute("loggedInUser");
int cartCount = 0;
if (loggedInUser != null) {
    try {
        CartDAOImpl cDao = new CartDAOImpl();
        Cart c = cDao.getCartByUserId(loggedInUser.getUserId());
        if (c != null) {
            CartItemDAOImpl ciDao = new CartItemDAOImpl();
            java.util.List<?> items = ciDao.getCartItems(c.getCartId());
            if (items != null) {
                cartCount = items.size();
            }
        }
    } catch (Exception e) {
        // Fallback silently if db query fails
    }
}
String currentUri = request.getRequestURI();
%>

<!-- Font Awesome 6 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<header class="header-wrapper">
    <nav class="navbar">
        <!-- Brand Logo -->
        <div class="logo">
            <a href="${pageContext.request.contextPath}/home">
                <span class="logo-icon"><i class="fa-solid fa-bag-shopping"></i></span>
                <span class="logo-text">Fashion<span class="logo-accent">Store</span></span>
            </a>
        </div>

        <!-- Search Bar with Neumorphic Inset -->
        <div class="search-bar">
            <form action="${pageContext.request.contextPath}/products" method="get" class="search-form">
                <input
                    type="text"
                    name="keyword"
                    placeholder="Search styles, brands, collections..."
                    value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>">
                <button type="submit" class="search-btn" aria-label="Search">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </button>
            </form>
        </div>

        <!-- Mobile Menu Hamburger Button -->
        <button class="mobile-toggle-btn" id="mobileMenuBtn" aria-label="Toggle Navigation Menu">
            <i class="fa-solid fa-bars"></i>
        </button>

        <!-- Navigation Links -->
        <ul class="nav-links" id="navLinks">
            <li>
                <a href="${pageContext.request.contextPath}/home" class="nav-link <%= currentUri.endsWith("/home") || currentUri.endsWith("/") || currentUri.endsWith("/index.jsp") ? "active" : "" %>">
                    <i class="fa-solid fa-house"></i> Home
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/products" class="nav-link <%= currentUri.contains("/products") || currentUri.contains("/product") ? "active" : "" %>">
                    <i class="fa-solid fa-shirt"></i> Products
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/cart" class="nav-link cart-link <%= currentUri.contains("/cart") ? "active" : "" %>">
                    <i class="fa-solid fa-cart-shopping"></i> Cart
                    <% if (cartCount > 0) { %>
                        <span class="cart-badge"><%= cartCount %></span>
                    <% } %>
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/orders" class="nav-link <%= currentUri.contains("/order") ? "active" : "" %>">
                    <i class="fa-solid fa-box-archive"></i> Orders
                </a>
            </li>

            <% if (loggedInUser == null) { %>
                <li>
                    <a href="${pageContext.request.contextPath}/login" class="nav-link nav-btn-outline <%= currentUri.contains("/login") ? "active" : "" %>">
                        <i class="fa-solid fa-arrow-right-to-bracket"></i> Login
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/register" class="nav-link nav-btn-solid <%= currentUri.contains("/register") ? "active" : "" %>">
                        <i class="fa-solid fa-user-plus"></i> Register
                    </a>
                </li>
            <% } else { %>
                <li class="user-pill-item">
                    <a href="${pageContext.request.contextPath}/profile" class="user-pill <%= currentUri.contains("/profile") ? "active" : "" %>" title="My Profile">
                        <span class="user-avatar"><i class="fa-solid fa-user"></i></span>
                        <span class="user-name"><%= loggedInUser.getFullName().split(" ")[0] %></span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/logout" class="nav-link logout-btn" title="Logout">
                        <i class="fa-solid fa-arrow-right-from-bracket"></i>
                    </a>
                </li>
            <% } %>

            <!-- Neumorphic Dark/Light Theme Toggle -->
            <li class="theme-toggle-item">
                <button id="themeToggleBtn" class="theme-toggle-btn" type="button" aria-label="Toggle Dark Mode" title="Toggle Dark/Light Mode">
                    <span class="toggle-track">
                        <i class="fa-solid fa-sun icon-sun"></i>
                        <i class="fa-solid fa-moon icon-moon"></i>
                        <span class="toggle-thumb"></span>
                    </span>
                </button>
            </li>
        </ul>
    </nav>
</header>

<style>
/* =========================================================
   LUXE NEUMORPHIC NAVBAR STYLES
   ========================================================= */
.header-wrapper {
    position: sticky;
    top: 0;
    z-index: 1000;
    background: var(--color-bg);
    padding: 14px 0;
    transition: var(--transition);
}

.navbar {
    width: 92%;
    max-width: 1240px;
    margin: 0 auto;
    background: var(--color-surface);
    box-shadow: var(--nm-flat);
    border-radius: var(--radius-pill);
    padding: 10px 24px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 16px;
    transition: var(--transition);
}

/* Brand Logo */
.logo a {
    display: flex;
    align-items: center;
    gap: 10px;
    font-size: 20px;
    font-weight: 800;
    color: var(--color-primary);
    text-decoration: none;
    letter-spacing: -0.5px;
}

.logo-icon {
    width: 38px;
    height: 38px;
    border-radius: 50%;
    background: linear-gradient(135deg, var(--color-accent), #b3924f);
    color: #ffffff;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 17px;
    box-shadow: 2px 2px 8px rgba(200, 169, 106, 0.4);
}

.logo-accent {
    color: var(--color-accent);
}

/* Search Bar */
.search-bar {
    flex: 1;
    max-width: 380px;
}

.search-form {
    position: relative;
    display: flex;
    align-items: center;
    width: 100%;
}

.search-form input {
    width: 100%;
    padding: 10px 45px 10px 18px;
    font-size: 13px;
    border-radius: var(--radius-pill);
    border: 1px solid transparent;
    background: var(--color-surface);
    color: var(--color-primary);
    box-shadow: var(--nm-inset-sm);
    outline: none;
    transition: var(--transition);
}

.search-form input:focus {
    border-color: var(--color-accent);
    box-shadow: var(--nm-inset), 0 0 0 3px var(--color-accent-light);
}

.search-btn {
    position: absolute;
    right: 5px;
    width: 32px;
    height: 32px;
    border-radius: 50%;
    border: none;
    background: var(--color-surface);
    box-shadow: var(--nm-flat-sm);
    color: var(--color-accent);
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 13px;
    transition: var(--transition);
}

.search-btn:hover {
    transform: scale(1.08);
    color: var(--color-primary);
    box-shadow: var(--nm-hover);
}

.search-btn:active {
    box-shadow: var(--nm-inset-sm);
}

/* Nav Links */
.nav-links {
    display: flex;
    align-items: center;
    gap: 12px;
    list-style: none;
}

.nav-link {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 8px 16px;
    font-size: 13px;
    font-weight: 600;
    color: var(--color-secondary);
    border-radius: var(--radius-pill);
    transition: var(--transition);
}

.nav-link i {
    font-size: 14px;
}

.nav-link:hover {
    color: var(--color-accent);
    box-shadow: var(--nm-flat-sm);
    background: var(--color-surface);
}

.nav-link.active {
    color: var(--color-accent);
    box-shadow: var(--nm-inset-sm);
    background: var(--color-surface);
}

/* Cart Badge */
.cart-link {
    position: relative;
}

.cart-badge {
    background: var(--color-accent);
    color: #ffffff;
    font-size: 11px;
    font-weight: 700;
    padding: 2px 7px;
    border-radius: var(--radius-pill);
    box-shadow: 0 2px 6px rgba(200, 169, 106, 0.4);
    margin-left: 4px;
}

/* User Pill */
.user-pill {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 6px 14px 6px 8px;
    border-radius: var(--radius-pill);
    background: var(--color-surface);
    box-shadow: var(--nm-flat-sm);
    font-size: 13px;
    font-weight: 600;
    color: var(--color-primary);
    transition: var(--transition);
}

.user-pill:hover, .user-pill.active {
    box-shadow: var(--nm-inset-sm);
    color: var(--color-accent);
}

.user-avatar {
    width: 26px;
    height: 26px;
    border-radius: 50%;
    background: var(--color-accent-light);
    color: var(--color-accent);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 12px;
}

.logout-btn {
    padding: 8px 12px !important;
    color: var(--color-danger) !important;
}

.logout-btn:hover {
    background: rgba(239, 68, 68, 0.1) !important;
    box-shadow: var(--nm-flat-sm) !important;
}

/* Mobile Toggle */
.mobile-toggle-btn {
    display: none;
    background: var(--color-surface);
    border: none;
    box-shadow: var(--nm-flat-sm);
    width: 38px;
    height: 38px;
    border-radius: 50%;
    color: var(--color-primary);
    font-size: 16px;
    cursor: pointer;
    align-items: center;
    justify-content: center;
}

/* Neumorphic Theme Toggle Switch */
.theme-toggle-item {
    display: inline-flex;
    align-items: center;
    margin-left: 6px;
}

.theme-toggle-btn {
    background: transparent;
    border: none;
    cursor: pointer;
    padding: 0;
    outline: none;
}

.theme-toggle-btn .toggle-track {
    width: 50px;
    height: 26px;
    border-radius: var(--radius-pill);
    background: var(--color-surface);
    box-shadow: var(--nm-inset-sm);
    position: relative;
    display: inline-flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 7px;
    box-sizing: border-box;
    transition: var(--transition);
}

.theme-toggle-btn .icon-sun {
    color: #f59e0b;
    font-size: 11px;
    z-index: 1;
}

.theme-toggle-btn .icon-moon {
    color: #64748b;
    font-size: 11px;
    z-index: 1;
}

.theme-toggle-btn .toggle-thumb {
    position: absolute;
    left: 3px;
    top: 3px;
    width: 20px;
    height: 20px;
    border-radius: 50%;
    background: #ffffff;
    box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
    transition: transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1), background-color 0.3s ease;
}

body.dark-mode .theme-toggle-btn .toggle-thumb {
    transform: translateX(24px);
    background: var(--color-accent);
}

body.dark-mode .theme-toggle-btn .icon-moon {
    color: #ffffff;
}

/* Responsive Navigation */
@media (max-width: 992px) {
    .mobile-toggle-btn {
        display: flex;
    }
    .search-bar {
        max-width: 240px;
    }
    .nav-links {
        position: absolute;
        top: 75px;
        left: 4%;
        right: 4%;
        background: var(--color-surface);
        box-shadow: var(--nm-flat-lg);
        border-radius: var(--radius-lg);
        flex-direction: column;
        align-items: stretch;
        padding: 20px;
        gap: 10px;
        display: none;
    }
    .nav-links.active {
        display: flex;
    }
    .nav-link {
        justify-content: flex-start;
        padding: 12px 18px;
    }
    .theme-toggle-item {
        margin: 10px auto 0 auto;
    }
}

@media (max-width: 576px) {
    .navbar {
        border-radius: var(--radius-md);
        padding: 10px 16px;
    }
    .search-bar {
        display: none; /* Can be opened or hidden on small mobile */
    }
}
</style>

<script>
// Theme persistence & toggling
(function() {
    var storedTheme = localStorage.getItem('fs_theme');
    if (storedTheme === 'dark' || (!storedTheme && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
        document.body.classList.add('dark-mode');
        document.documentElement.classList.add('dark-mode');
    }

    document.addEventListener('DOMContentLoaded', function() {
        var toggleBtn = document.getElementById('themeToggleBtn');
        if (toggleBtn) {
            toggleBtn.addEventListener('click', function(e) {
                e.preventDefault();
                document.body.classList.toggle('dark-mode');
                document.documentElement.classList.toggle('dark-mode');
                var isDark = document.body.classList.contains('dark-mode');
                localStorage.setItem('fs_theme', isDark ? 'dark' : 'light');
            });
        }

        var mobileBtn = document.getElementById('mobileMenuBtn');
        var navLinks = document.getElementById('navLinks');
        if (mobileBtn && navLinks) {
            mobileBtn.addEventListener('click', function() {
                navLinks.classList.toggle('active');
            });
        }
    });
})();
</script>