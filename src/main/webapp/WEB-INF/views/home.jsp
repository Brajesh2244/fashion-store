<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fashionstore.model.Category"%>
<%@ page import="com.fashionstore.model.Product"%>
<%@ page import="java.math.BigDecimal"%>

<%
List<Category> categories = (List<Category>) request.getAttribute("categories");
List<Product> products = (List<Product>) request.getAttribute("products");

// Helper map / array for high-definition category showcase images
java.util.Map<String, String> categoryImages = new java.util.HashMap<>();
categoryImages.put("men", "https://images.unsplash.com/photo-1617137984095-74e4e5e3613f?auto=format&fit=crop&w=800&q=80");
categoryImages.put("women", "https://images.unsplash.com/photo-1483985988355-763728e1935b?auto=format&fit=crop&w=800&q=80");
categoryImages.put("kids", "https://images.unsplash.com/photo-1518831959646-742c3a14ebf7?auto=format&fit=crop&w=800&q=80");
categoryImages.put("shoes", "https://images.unsplash.com/photo-1549298916-b41d501d3772?auto=format&fit=crop&w=800&q=80");
categoryImages.put("watches", "https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?auto=format&fit=crop&w=800&q=80");
categoryImages.put("bags", "https://images.unsplash.com/photo-1548036328-c9fa89d128fa?auto=format&fit=crop&w=800&q=80");
categoryImages.put("accessories", "https://images.unsplash.com/photo-1511499767150-a48a237f0083?auto=format&fit=crop&w=800&q=80");
categoryImages.put("sportswear", "https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&w=800&q=80");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FashionStore | Luxury Editorial Collection</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=3">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/home.css?v=3">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<%@ include file="partials/navbar.jsp"%>

<!-- HERO CINEMATIC BANNER -->
<section class="hero">
    <video autoplay loop muted playsinline class="hero-video">
        <source src="https://raw.githubusercontent.com/jxlee007/PROJECT-5-Sundown/main/media/video.mp4" type="video/mp4">
    </video>
    <div class="hero-overlay"></div>
    <div class="hero-content">
        <div class="hero-tagline">
            <i class="fa-solid fa-sparkles"></i> New Season 2026 Collection
        </div>
        <h1>Curated Fashion for the Modern Aesthetic</h1>
        <p>Explore an exclusive catalog of luxury apparel, footwear, and accessories tailored with precision and unmatched craftsmanship.</p>
        <div class="hero-buttons">
            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">
                <i class="fa-solid fa-bag-shopping"></i> Explore Collection
            </a>
            <a href="${pageContext.request.contextPath}/products?sort=latest" class="btn btn-secondary">
                <i class="fa-solid fa-fire"></i> New Arrivals
            </a>
        </div>
    </div>
</section>

<!-- MAIN CONTAINER -->
<div class="container">

    <!-- TRUST BADGES SECTION -->
    <div class="trust-bar">
        <div class="trust-item">
            <div class="trust-icon"><i class="fa-solid fa-truck-fast"></i></div>
            <div class="trust-info">
                <h4>Free Express Delivery</h4>
                <p>On all domestic orders over ₹999</p>
            </div>
        </div>
        <div class="trust-item">
            <div class="trust-icon"><i class="fa-solid fa-certificate"></i></div>
            <div class="trust-info">
                <h4>100% Authentic</h4>
                <p>Curated directly from verified labels</p>
            </div>
        </div>
        <div class="trust-item">
            <div class="trust-icon"><i class="fa-solid fa-arrow-rotate-left"></i></div>
            <div class="trust-info">
                <h4>7-Day Free Returns</h4>
                <p>Hassle-free instant exchanges</p>
            </div>
        </div>
        <div class="trust-item">
            <div class="trust-icon"><i class="fa-solid fa-lock"></i></div>
            <div class="trust-info">
                <h4>Secure Payments</h4>
                <p>Encrypted UPI, Cards & COD</p>
            </div>
        </div>
    </div>

    <!-- CATEGORY SHOWCASE SECTION -->
    <h2 class="section-title">Shop By Curated Category</h2>
    <div class="category-container">
        <% if(categories != null) {
            for(Category cat : categories) {
                String catKey = cat.getCategoryName().toLowerCase().trim();
                String imgUrl = categoryImages.getOrDefault(catKey, "https://images.unsplash.com/photo-1441986300917-64674bd600d8?auto=format&fit=crop&w=800&q=80");
        %>
            <a href="${pageContext.request.contextPath}/products?category=<%=cat.getCategoryId()%>" class="category-card">
                <img src="<%= imgUrl %>" alt="<%= cat.getCategoryName() %>" class="category-img" loading="lazy">
                <div class="category-overlay">
                    <span class="category-badge">Explore Category</span>
                    <h3><%= cat.getCategoryName() %></h3>
                    <span class="category-explore">Discover Style <i class="fa-solid fa-arrow-right"></i></span>
                </div>
            </a>
        <%  }
        } %>
    </div>

    <!-- FEATURED PRODUCTS SECTION -->
    <h2 class="section-title">Featured Highlights</h2>
    <div class="product-container">
        <% if(products != null) {
            int count = 0;
            for(Product product : products) {
                if(count >= 8) break;
                count++;
                BigDecimal price = product.getPrice();
                double originalPrice = price != null ? price.doubleValue() * 1.3 : 1999.0;
        %>
                <div class="product-card">
                    <div class="product-image-wrap">
                        <span class="product-badge-pill">Trending</span>
                        <img src="${pageContext.request.contextPath}/<%=product.getImageUrl()%>" alt="<%=product.getProductName()%>" loading="lazy">
                    </div>
                    <div class="product-info">
                        <span class="brand"><%=product.getBrand()%></span>
                        <h3 title="<%=product.getProductName()%>"><%=product.getProductName()%></h3>
                        <div class="product-rating">
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star-half-stroke"></i>
                            <span>4.8 (124)</span>
                        </div>
                        <div class="product-price-row">
                            <span class="price">₹ <%=product.getPrice()%></span>
                            <span class="mrp">₹ <%= String.format("%.0f", originalPrice) %></span>
                            <span class="discount">30% OFF</span>
                        </div>
                        <a href="${pageContext.request.contextPath}/product?id=<%=product.getProductId()%>" class="view-btn">
                            <i class="fa-solid fa-eye"></i> View Details
                        </a>
                    </div>
                </div>
        <%  }
        } %>
    </div>

    <!-- LATEST ARRIVALS SECTION -->
    <h2 class="section-title">Latest Arrivals</h2>
    <div class="product-container">
        <% if(products != null && products.size() > 8) {
            int shown = 0;
            // Iterate from end
            for(int i = products.size() - 1; i >= 0 && shown < 8; i--, shown++) {
                Product product = products.get(i);
                BigDecimal price = product.getPrice();
                double originalPrice = price != null ? price.doubleValue() * 1.25 : 1999.0;
        %>
                <div class="product-card">
                    <div class="product-image-wrap">
                        <span class="product-badge-pill">New Arrival</span>
                        <img src="${pageContext.request.contextPath}/<%=product.getImageUrl()%>" alt="<%=product.getProductName()%>" loading="lazy">
                    </div>
                    <div class="product-info">
                        <span class="brand"><%=product.getBrand()%></span>
                        <h3 title="<%=product.getProductName()%>"><%=product.getProductName()%></h3>
                        <div class="product-rating">
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <span>5.0 (86)</span>
                        </div>
                        <div class="product-price-row">
                            <span class="price">₹ <%=product.getPrice()%></span>
                            <span class="mrp">₹ <%= String.format("%.0f", originalPrice) %></span>
                            <span class="discount">25% OFF</span>
                        </div>
                        <a href="${pageContext.request.contextPath}/product?id=<%=product.getProductId()%>" class="view-btn">
                            <i class="fa-solid fa-eye"></i> View Details
                        </a>
                    </div>
                </div>
        <%  }
        } %>
    </div>

</div>

<%@ include file="partials/footer.jsp"%>

</body>
</html>