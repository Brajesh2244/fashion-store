<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fashionstore.model.Product"%>
<%@ page import="com.fashionstore.model.ProductVariant"%>

<%
Product product = (Product) request.getAttribute("product");
List<ProductVariant> variants = (List<ProductVariant>) request.getAttribute("variants");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title><%= product.getProductName() %> | Fashion Store</title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/assets/css/style.css?v=2">

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/assets/css/product-details.css?v=2">

</head>

<body>

<%@ include file="partials/navbar.jsp"%>

<div class="container">

    <div class="product-details-container">

        <!-- Product Image -->

        <div class="product-image">

            <img src="${pageContext.request.contextPath}/<%= product.getImageUrl() %>"
                 alt="<%= product.getProductName() %>">

        </div>

        <!-- Product Information -->

        <div class="product-info">

            <h1><%= product.getProductName() %></h1>

            <h3>Brand : <%= product.getBrand() %></h3>

            <p><%= product.getDescription() %></p>

            <div class="price">

                ₹ <%= product.getPrice() %>

            </div>

            <!-- Add To Cart Form -->

            <form action="${pageContext.request.contextPath}/cart" method="post">

                <input
                        type="hidden"
                        name="productId"
                        value="<%= product.getProductId() %>">

                <h4>Select Size</h4>

                <div class="sizes">

                    <select name="variantId" required>

                        <% for(ProductVariant variant : variants){ %>

                            <option value="<%= variant.getVariantId() %>">

                                <%= variant.getSize() %>

                            </option>

                        <% } %>

                    </select>

                </div>

                <div class="quantity-box">

                    <h4>Quantity</h4>

                    <input
                            type="number"
                            name="quantity"
                            value="1"
                            min="1"
                            required>

                </div>

                <p class="stock">

                    ✓ In Stock

                </p>

                <button
                        type="submit"
                        class="cart-btn">

                    Add To Cart

                </button>

            </form>

        </div>

    </div>

</div>

<%@ include file="partials/footer.jsp"%>

</body>

</html>