<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fashionstore.model.Order"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
List<Order> orders = (List<Order>) request.getAttribute("orders");
SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy, hh:mm a");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders | FashionStore</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=3">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/orders.css?v=3">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<%@ include file="partials/navbar.jsp"%>

<div class="container">
    <h1 class="page-title">My Order History</h1>

    <% if(orders == null || orders.isEmpty()) { %>
        <!-- Empty Orders State -->
        <div class="empty-orders-card">
            <i class="fa-solid fa-box-open"></i>
            <h3>No Orders Placed Yet</h3>
            <p>You haven't placed any orders yet. Discover our curated collections and place your first order today!</p>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">
                <i class="fa-solid fa-bag-shopping"></i> Start Shopping
            </a>
        </div>
    <% } else { %>
        <!-- Orders List Table Card -->
        <div class="orders-container-card">
            <table class="orders-table">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Order Date</th>
                        <th>Total Amount</th>
                        <th>Payment Method</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for(Order order : orders) {
                        String formattedDate = order.getOrderDate() != null ? sdf.format(order.getOrderDate()) : "N/A";
                        String statusClass = "pending".equalsIgnoreCase(order.getStatus()) ? "status-pill pending" : "status-pill";
                    %>
                        <tr>
                            <td>
                                <span class="order-id-tag">#<%= order.getOrderId() %></span>
                            </td>
                            <td>
                                <span class="order-date-text"><%= formattedDate %></span>
                            </td>
                            <td>
                                <span class="order-amount-text">₹ <%= String.format("%.2f", order.getTotalAmount()) %></span>
                            </td>
                            <td>
                                <span style="font-weight: 600;"><%= order.getPaymentMethod() %></span>
                            </td>
                            <td>
                                <span class="<%= statusClass %>">
                                    <i class="fa-solid fa-circle-dot"></i> <%= order.getStatus() %>
                                </span>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/order-details?orderId=<%= order.getOrderId() %>" class="order-action-btn">
                                    <i class="fa-solid fa-file-invoice"></i> View Invoice
                                </a>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    <% } %>
</div>

<%@ include file="partials/footer.jsp"%>

</body>
</html>