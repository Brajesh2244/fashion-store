<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.fashionstore.model.Order"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
Order order = (Order) request.getAttribute("order");
SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy, hh:mm a");
String formattedDate = (order != null && order.getOrderDate() != null) ? sdf.format(order.getOrderDate()) : "";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Placed Successfully | FashionStore</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=3">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/order-success.css?v=3">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<%@ include file="partials/navbar.jsp"%>

<div class="container success-page-container">
    <div class="success-card">
        <!-- Circular Emerald Check Badge -->
        <div class="success-icon-badge">
            <i class="fa-solid fa-check"></i>
        </div>
        
        <h1 class="success-title">Order Placed Successfully!</h1>
        <p class="success-subtitle">Thank you for your purchase. We are preparing your order for express dispatch.</p>
        
        <% if (order != null) { %>
            <div class="details-box">
                <div class="detail-row">
                    <span class="detail-label">Order Reference</span>
                    <span class="detail-value">#<%= order.getOrderId() %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Order Placed On</span>
                    <span class="detail-value"><%= formattedDate %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Payment Method</span>
                    <span class="detail-value"><%= order.getPaymentMethod() %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Shipping Address</span>
                    <span class="detail-value" style="font-size: 13px; max-width: 280px; text-align: right;"><%= order.getShippingAddress() %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Current Status</span>
                    <span class="status-badge"><i class="fa-solid fa-circle-check"></i> <%= order.getStatus() %></span>
                </div>
                <div class="detail-row total-row">
                    <span class="detail-label">Paid Total Amount</span>
                    <span class="detail-value grand-total-value">₹ <%= String.format("%.2f", order.getTotalAmount()) %></span>
                </div>
            </div>
        <% } %>

        <div class="success-actions">
            <a href="${pageContext.request.contextPath}/orders" class="btn btn-primary">
                <i class="fa-solid fa-box-archive"></i> View All Orders
            </a>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary">
                <i class="fa-solid fa-bag-shopping"></i> Continue Shopping
            </a>
        </div>
    </div>
</div>

<%@ include file="partials/footer.jsp"%>

</body>
</html>
