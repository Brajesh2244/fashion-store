<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fashionstore.model.Product"%>
<%@ page import="com.fashionstore.model.Category"%>

<%
List<Product> products = (List<Product>) request.getAttribute("products");
List<Category> categories = (List<Category>) request.getAttribute("categories");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Products | Fashion Store</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/assets/css/style.css?v=2">

<link rel="stylesheet"
href="${pageContext.request.contextPath}/assets/css/product.css?v=2">

</head>

<body>

<%@ include file="partials/navbar.jsp"%>

<div class="container">

<h1 class="page-title">Our Products</h1>

<!-- FILTER SECTION -->

<div class="filter-section">

<form action="${pageContext.request.contextPath}/products" method="get">

<input
type="text"
name="keyword"
placeholder="Search Product...">

<select name="category">

<option value="">All Categories</option>

<%
for(Category category : categories){
%>

<option value="<%=category.getCategoryId()%>">

<%=category.getCategoryName()%>

</option>

<%
}
%>

</select>

<select name="sort">

<option value="">Sort By</option>

<option value="low">Price : Low to High</option>

<option value="high">Price : High to Low</option>

<option value="latest">Newest</option>

</select>

<button class="btn">

Apply

</button>

</form>

</div>

<!-- PRODUCT GRID -->

<div class="product-grid">

<%
if (products == null || products.isEmpty()) {
%>
    <div class="no-products" style="grid-column: 1 / -1; text-align: center; padding: 50px; background: #fff; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05);">
        <h3 style="color: #4b5563; font-size: 20px; margin-bottom: 10px;">No products found in this category.</h3>
        <p style="color: #9ca3af;">Try browsing our other collections!</p>
    </div>
<%
} else {
    for(Product product : products){
%>

<div class="product-card">

<img
src="${pageContext.request.contextPath}/<%=product.getImageUrl()%>"
alt="<%=product.getProductName()%>">

<div class="product-details">

<h3>

<%=product.getProductName()%>

</h3>

<p class="brand">

<%=product.getBrand()%>

</p>

<p class="description">

<%=product.getDescription()%>

</p>

<div class="price">

₹ <%=product.getPrice()%>

</div>

<a
href="${pageContext.request.contextPath}/product?id=<%=product.getProductId()%>"
class="btn">

View Details

</a>

</div>

</div>

<%

}
}

%>

</div>

</div>

<%@ include file="partials/footer.jsp"%>

</body>

</html>