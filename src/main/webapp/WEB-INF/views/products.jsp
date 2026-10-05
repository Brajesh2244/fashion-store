<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fashionstore.model.Product"%>
<%@ page import="com.fashionstore.model.Category"%>
<%@ page import="java.math.BigDecimal"%>

<%
List<Product> products = (List<Product>) request.getAttribute("products");
List<Category> categories = (List<Category>) request.getAttribute("categories");

String selectedCategory = request.getParameter("category");
String selectedSort = request.getParameter("sort");
String searchKeyword = request.getParameter("keyword");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Curated Collections | FashionStore</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=3">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product.css?v=3">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<%@ include file="partials/navbar.jsp"%>

<div class="container">
    <h1 class="page-title">Curated Collections</h1>

    <!-- NEUMORPHIC FILTER & SEARCH SECTION -->
    <div class="filter-section">
        <form action="${pageContext.request.contextPath}/products" method="get" class="filter-form">
            <!-- Search Keyword Input -->
            <div class="filter-input-wrap">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input
                    type="text"
                    name="keyword"
                    placeholder="Search by product or brand name..."
                    value="<%= searchKeyword != null ? searchKeyword : "" %>">
            </div>

            <!-- Category Dropdown -->
            <select name="category" class="filter-select">
                <option value="">All Categories</option>
                <% if(categories != null) {
                    for(Category cat : categories) {
                        String isSel = (selectedCategory != null && selectedCategory.equals(String.valueOf(cat.getCategoryId()))) ? "selected" : "";
                %>
                    <option value="<%= cat.getCategoryId() %>" <%= isSel %>>
                        <%= cat.getCategoryName() %>
                    </option>
                <%  }
                } %>
            </select>

            <!-- Sort Dropdown -->
            <select name="sort" class="filter-select">
                <option value="">Sort By: Default</option>
                <option value="low" <%= "low".equals(selectedSort) ? "selected" : "" %>>Price: Low to High</option>
                <option value="high" <%= "high".equals(selectedSort) ? "selected" : "" %>>Price: High to Low</option>
                <option value="latest" <%= "latest".equals(selectedSort) ? "selected" : "" %>>Newest Additions</option>
            </select>

            <!-- Filter Buttons -->
            <button type="submit" class="btn btn-primary filter-btn">
                <i class="fa-solid fa-filter"></i> Apply
            </button>

            <a href="${pageContext.request.contextPath}/products" class="btn filter-reset-btn" title="Reset Filters">
                <i class="fa-solid fa-arrows-rotate"></i> Reset
            </a>
        </form>
    </div>

    <!-- CATALOG STATS -->
    <div class="catalog-stats">
        <span>Showing <strong><%= products != null ? products.size() : 0 %></strong> styles found</span>
        <% if (selectedCategory != null && !selectedCategory.isEmpty()) { %>
            <span>Category Filter Active</span>
        <% } %>
    </div>

    <!-- PRODUCT GRID -->
    <div class="product-grid">
        <% if (products == null || products.isEmpty()) { %>
            <div class="no-products">
                <i class="fa-regular fa-folder-open"></i>
                <h3>No Matching Products Found</h3>
                <p>We couldn't find any products matching your selected criteria. Try adjusting your search or filters.</p>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">
                    <i class="fa-solid fa-bag-shopping"></i> Browse All Styles
                </a>
            </div>
        <% } else {
            for(Product product : products) {
                BigDecimal price = product.getPrice();
                double originalPrice = price != null ? price.doubleValue() * 1.3 : 1999.0;
        %>
            <div class="product-card">
                <div class="product-thumb-wrap">
                    <span class="product-tag">Exclusive</span>
                    <img
                        src="${pageContext.request.contextPath}/<%= product.getImageUrl() %>"
                        alt="<%= product.getProductName() %>"
                        loading="lazy">
                </div>
                <div class="product-details">
                    <span class="brand"><%= product.getBrand() %></span>
                    <h3 title="<%= product.getProductName() %>"><%= product.getProductName() %></h3>
                    <p class="description"><%= product.getDescription() %></p>
                    
                    <div class="product-rating">
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star-half-stroke"></i>
                        <span>4.7 (95)</span>
                    </div>

                    <div class="price-container">
                        <span class="price">₹ <%= product.getPrice() %></span>
                        <span class="mrp">₹ <%= String.format("%.0f", originalPrice) %></span>
                        <span class="discount">30% OFF</span>
                    </div>

                    <a href="${pageContext.request.contextPath}/product?id=<%= product.getProductId() %>" class="btn-view">
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