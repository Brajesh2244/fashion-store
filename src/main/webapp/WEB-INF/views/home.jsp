<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fashionstore.model.Category"%>
<%@ page import="com.fashionstore.model.Product"%>

<%
List<Category> categories = (List<Category>) request.getAttribute("categories");
List<Product> products = (List<Product>) request.getAttribute("products");
%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Fashion Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/home.css?v=2">
</head>

<body>

<%@ include file="partials/navbar.jsp"%>

<!-- HERO SECTION -->
<section class="hero">
    <!-- Background Video -->
    <video autoplay loop muted playsinline class="hero-video">
        <source src="https://raw.githubusercontent.com/jxlee007/PROJECT-5-Sundown/main/media/video.mp4" type="video/mp4">
    </video>
    <div class="hero-content">
        <h4>Welcome To FashionStore</h4>
        <h1>Discover Your Perfect Style</h1>
        <p>Shop the latest fashion trends with premium quality products at affordable prices.</p>
        <div class="hero-buttons">
            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Shop Collection</a>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary">Explore Products</a>
        </div>
    </div>
</section>

<!-- CATEGORY SECTION -->
<h2 class="section-title">Shop By Category</h2>
<div class="category-container">
    <% if(categories != null) {
        for(Category category : categories) { %>
            <a href="${pageContext.request.contextPath}/products?category=<%=category.getCategoryId()%>" class="category-card-link">
                <div class="category-card">
                    <h3><%=category.getCategoryName()%></h3>
                </div>
            </a>
    <%  }
    } %>
</div>

<!-- FEATURED PRODUCTS SECTION -->
<h2 class="section-title">Featured Products</h2>
<div class="product-container">
    <% if(products != null) {
        int count = 0;
        for(Product product : products) {
            if(count >= 4) break;
            count++; %>
            <div class="product-card">
                <img src="${pageContext.request.contextPath}/<%=product.getImageUrl()%>" alt="<%=product.getProductName()%>">
                <div class="product-info">
                    <p class="brand"><%=product.getBrand()%></p>
                    <h3><%=product.getProductName()%></h3>
                    <div class="price">₹ <%=product.getPrice()%></div>
                    <a href="${pageContext.request.contextPath}/product?id=<%=product.getProductId()%>" class="view-btn">View Details</a>
                </div>
            </div>
    <%  }
    } %>
</div>

<!-- LATEST PRODUCTS SECTION -->
<h2 class="section-title">Latest Products</h2>
<div class="product-container">
    <% if(products != null) {
        int count = 0;
        // Start from end of list or show next batch
        int startIndex = Math.max(0, products.size() - 4);
        for(int i = products.size() - 1; i >= startIndex; i--) {
            Product product = products.get(i); %>
            <div class="product-card">
                <img src="${pageContext.request.contextPath}/<%=product.getImageUrl()%>" alt="<%=product.getProductName()%>">
                <div class="product-info">
                    <p class="brand"><%=product.getBrand()%></p>
                    <h3><%=product.getProductName()%></h3>
                    <div class="price">₹ <%=product.getPrice()%></div>
                    <a href="${pageContext.request.contextPath}/product?id=<%=product.getProductId()%>" class="view-btn">View Details</a>
                </div>
            </div>
    <%  }
    } %>
</div>

<%@ include file="partials/footer.jsp"%>

</body>
</html>