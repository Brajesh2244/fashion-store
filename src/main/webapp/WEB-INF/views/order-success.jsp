<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.fashionstore.model.Order"%>
<%@ page import="com.fashionstore.model.User"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
Order order = (Order) request.getAttribute("order");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
String formattedDate = (order != null && order.getOrderDate() != null) ? sdf.format(order.getOrderDate()) : "";
%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Order Success | Fashion Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/order-success.css?v=2">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<body class="success-page-body">

<%@ include file="partials/navbar.jsp"%>

<div class="container success-page-container">
    <div class="success-card">
        <!-- Circular Green Check Badge -->
        <div class="success-icon-badge">
            <i class="fa-solid fa-check"></i>
        </div>
        
        <h1 class="success-title">Order Placed Successfully</h1>
        <p class="success-subtitle">Your order has been placed successfully and is now being processed.</p>
        
        <% if (order != null) { %>
            <!-- Order Details Box -->
            <div class="details-box">
                <div class="detail-row">
                    <span class="detail-label">Order ID</span>
                    <span class="detail-value">#<%= order.getOrderId() %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Order Date</span>
                    <span class="detail-value"><%= formattedDate %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Payment Method</span>
                    <span class="detail-value"><%= order.getPaymentMethod() %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Status</span>
                    <span class="detail-value status-text"><%= order.getStatus() %></span>
                </div>
                <div class="detail-row total-row">
                    <span class="detail-label">Total Amount</span>
                    <span class="detail-value grand-total-value">₹ <%= String.format("%.2f", order.getTotalAmount()) %></span>
                </div>
            </div>

            <!-- Delivery Details Box -->
            <div class="details-box delivery-details-box">
                <h3>Delivery Details</h3>
                <% if (loggedInUser != null) { %>
                    <p class="delivery-name"><%= loggedInUser.getFullName() %></p>
                    <p class="delivery-phone"><%= loggedInUser.getPhone() %></p>
                <% } %>
                <p class="delivery-address"><%= order.getShippingAddress() %></p>
            </div>
        <% } %>
        
        <!-- Action Buttons -->
        <div class="success-actions">
            <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary">Continue Shopping</a>
            <a href="${pageContext.request.contextPath}/orders" class="btn btn-primary">View Orders</a>
        </div>
    </div>
</div>

<%@ include file="partials/footer.jsp"%>

</body>
</html>
