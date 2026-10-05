<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fashionstore.model.Product"%>
<%@ page import="com.fashionstore.model.ProductVariant"%>
<%@ page import="java.math.BigDecimal"%>

<%
Product product = (Product) request.getAttribute("product");
List<ProductVariant> variants = (List<ProductVariant>) request.getAttribute("variants");

if (product == null) {
    response.sendRedirect(request.getContextPath() + "/products");
    return;
}

BigDecimal price = product.getPrice();
double originalPrice = price != null ? price.doubleValue() * 1.3 : 1999.0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= product.getProductName() %> | FashionStore</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=3">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-details.css?v=3">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<%@ include file="partials/navbar.jsp"%>

<div class="container">
    <!-- Breadcrumb -->
    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/home">Home</a>
        <span>/</span>
        <a href="${pageContext.request.contextPath}/products">Products</a>
        <span>/</span>
        <span><%= product.getProductName() %></span>
    </div>

    <!-- Product Details Card -->
    <div class="product-details-container">
        <!-- Image Box -->
        <div class="product-image-box">
            <img
                src="${pageContext.request.contextPath}/<%= product.getImageUrl() %>"
                alt="<%= product.getProductName() %>">
        </div>

        <!-- Info & Form Box -->
        <div class="product-info-box">
            <span class="brand-label"><%= product.getBrand() %></span>
            <h1><%= product.getProductName() %></h1>

            <div class="product-rating-box">
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star-half-stroke"></i>
                <span>4.8 (148 verified customer ratings)</span>
            </div>

            <p class="product-desc"><%= product.getDescription() %></p>

            <div class="product-price-section">
                <span class="current-price">₹ <%= product.getPrice() %></span>
                <span class="original-price">₹ <%= String.format("%.0f", originalPrice) %></span>
                <span class="discount-tag">Save 30% Today</span>
            </div>

            <!-- Form: Add to Cart -->
            <form action="${pageContext.request.contextPath}/cart" method="post">
                <input type="hidden" name="productId" value="<%= product.getProductId() %>">

                <!-- Variant Selector -->
                <div class="variant-selection">
                    <h4>Select Size</h4>
                    <select name="variantId" class="variant-select" required>
                        <% if(variants != null && !variants.isEmpty()) {
                            for(ProductVariant variant : variants) {
                        %>
                            <option value="<%= variant.getVariantId() %>">
                                Size <%= variant.getSize() %> (Stock: <%= variant.getStock() %> available)
                            </option>
                        <%  }
                        } else { %>
                            <option value="1">Standard Size</option>
                        <% } %>
                    </select>
                </div>

                <!-- Quantity -->
                <div class="quantity-selection">
                    <h4>Quantity</h4>
                    <div class="qty-input-wrap">
                        <input type="number" name="quantity" value="1" min="1" max="10" required>
                    </div>
                </div>

                <div class="stock-status">
                    <i class="fa-solid fa-circle-check"></i> In Stock & Ready for Express Dispatch
                </div>

                <!-- Add to Cart CTA -->
                <button type="submit" class="cart-action-btn">
                    <i class="fa-solid fa-cart-shopping"></i> Add To Shopping Cart
                </button>
            </form>

            <!-- Guarantees Grid -->
            <div class="product-guarantees">
                <div class="guarantee-item">
                    <i class="fa-solid fa-truck-fast"></i>
                    <span>Free Standard Shipping</span>
                </div>
                <div class="guarantee-item">
                    <i class="fa-solid fa-arrow-rotate-left"></i>
                    <span>7-Day Return & Exchange</span>
                </div>
                <div class="guarantee-item">
                    <i class="fa-solid fa-shield-check"></i>
                    <span>100% Verified Quality</span>
                </div>
                <div class="guarantee-item">
                    <i class="fa-solid fa-lock"></i>
                    <span>Encrypted Safe Payment</span>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="partials/footer.jsp"%>

</body>
</html>