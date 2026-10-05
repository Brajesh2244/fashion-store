<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fashionstore.model.CartView"%>

<%
List<CartView> cartItems = (List<CartView>) request.getAttribute("cartItems");
Double cartTotal = (Double) request.getAttribute("cartTotal");

if(cartTotal == null){
    cartTotal = 0.0;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Shopping Cart | FashionStore</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=3">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/cart.css?v=3">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<%@ include file="partials/navbar.jsp"%>

<div class="container">
    <!-- Step Indicator -->
    <div class="checkout-steps">
        <div class="step-item active">
            <span class="step-num">1</span>
            <span>Shopping Cart</span>
        </div>
        <div class="step-line"></div>
        <div class="step-item">
            <span class="step-num">2</span>
            <span>Shipping</span>
        </div>
        <div class="step-line"></div>
        <div class="step-item">
            <span class="step-num">3</span>
            <span>Payment</span>
        </div>
    </div>

    <h1 class="page-title">Shopping Cart</h1>

    <% if(cartItems == null || cartItems.isEmpty()) { %>
        <!-- Empty Cart -->
        <div class="empty-cart-card">
            <div class="empty-cart-icon">
                <i class="fa-solid fa-bag-shopping"></i>
            </div>
            <h3>Your Shopping Cart is Empty</h3>
            <p>Looks like you haven't added anything to your cart yet. Explore our latest arrivals and elevate your wardrobe!</p>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">
                <i class="fa-solid fa-arrow-left"></i> Start Shopping Now
            </a>
        </div>
    <% } else { %>
        <!-- Cart Layout -->
        <div class="cart-layout">
            <!-- Items Table -->
            <div class="cart-table-card">
                <table class="cart-table">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Size</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Subtotal</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(CartView item : cartItems) { %>
                            <tr>
                                <td>
                                    <div class="cart-product-info">
                                        <img src="${pageContext.request.contextPath}/<%= item.getImageUrl() %>" class="cart-thumb" alt="<%= item.getProductName() %>">
                                        <div class="cart-details">
                                            <span class="cart-brand"><%= item.getBrand() %></span>
                                            <h4><%= item.getProductName() %></h4>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <span class="cart-size-pill"><%= item.getSize() %></span>
                                </td>
                                <td>
                                    <span class="cart-price">₹ <%= item.getPrice() %></span>
                                </td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/update-cart" method="post" class="cart-qty-form">
                                        <input type="hidden" name="cartItemId" value="<%= item.getCartItemId() %>">
                                        <input type="number" name="quantity" value="<%= item.getQuantity() %>" min="1" max="10" class="cart-qty-input">
                                        <button type="submit" class="cart-qty-btn" title="Update Quantity">Update</button>
                                    </form>
                                </td>
                                <td>
                                    <span class="cart-price">₹ <%= item.getSubTotal() %></span>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/remove-cart-item?id=<%= item.getCartItemId() %>" class="cart-delete-btn" title="Remove item from cart">
                                        <i class="fa-regular fa-trash-can"></i>
                                    </a>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <!-- Order Summary Card -->
            <div class="summary-card">
                <h3>Order Summary</h3>
                <div class="summary-row">
                    <span>Subtotal (<%= cartItems.size() %> items)</span>
                    <span>₹ <%= String.format("%.2f", cartTotal) %></span>
                </div>
                <div class="summary-row">
                    <span>Estimated Shipping</span>
                    <span style="color: var(--color-success); font-weight: 700;">FREE</span>
                </div>
                <div class="summary-row">
                    <span>Tax Estimate (GST Incl.)</span>
                    <span>₹ 0.00</span>
                </div>
                <div class="summary-row total-row">
                    <span>Total Amount</span>
                    <span class="total-amount">₹ <%= String.format("%.2f", cartTotal) %></span>
                </div>

                <a href="${pageContext.request.contextPath}/checkout" class="checkout-action-btn">
                    <i class="fa-solid fa-lock"></i> Proceed to Checkout
                </a>

                <a href="${pageContext.request.contextPath}/products" class="continue-shopping-link">
                    <i class="fa-solid fa-arrow-left"></i> Continue Shopping
                </a>
            </div>
        </div>
    <% } %>
</div>

<%@ include file="partials/footer.jsp"%>

</body>
</html>
