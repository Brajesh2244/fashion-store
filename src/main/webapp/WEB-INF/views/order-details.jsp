<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fashionstore.model.Order"%>
<%@ page import="com.fashionstore.model.OrderItemView"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
Order order = (Order) request.getAttribute("order");
List<OrderItemView> orderItems = (List<OrderItemView>) request.getAttribute("orderItems");

if (order == null) {
    response.sendRedirect(request.getContextPath() + "/orders");
    return;
}

SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy, hh:mm a");
String orderDate = order.getOrderDate() != null ? sdf.format(order.getOrderDate()) : "N/A";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice #<%= order.getOrderId() %> | FashionStore</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=3">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/orders.css?v=3">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<%@ include file="partials/navbar.jsp"%>

<div class="container">
    <div class="order-details-card">
        <!-- Header Bar -->
        <div class="order-header-bar">
            <div class="order-meta-info">
                <h2>Tax Invoice #<%= order.getOrderId() %></h2>
                <p><i class="fa-regular fa-calendar"></i> Placed on: <%= orderDate %></p>
            </div>
            <div>
                <span class="status-pill">
                    <i class="fa-solid fa-circle-check"></i> <%= order.getStatus() %>
                </span>
            </div>
        </div>

        <!-- Order Info Grid -->
        <div class="order-details-grid">
            <!-- Items Table -->
            <div>
                <h3 style="font-size: 18px; margin-bottom: 16px; color: var(--color-primary);">Ordered Items (<%= orderItems != null ? orderItems.size() : 0 %>)</h3>
                <table class="invoice-table">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Size</th>
                            <th>Unit Price</th>
                            <th>Qty</th>
                            <th>Subtotal</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if(orderItems != null) {
                            for(OrderItemView item : orderItems) {
                                String img = item.getImageUrl();
                                if(img == null || img.trim().isEmpty()) {
                                    img = "assets/images/no-image.png";
                                }
                        %>
                            <tr>
                                <td>
                                    <div class="invoice-product-cell">
                                        <img src="${pageContext.request.contextPath}/<%= img %>" class="invoice-thumb" alt="<%= item.getProductName() %>">
                                        <div>
                                            <span style="font-size: 11px; font-weight: 700; color: var(--color-accent); text-transform: uppercase;"><%= item.getBrand() %></span>
                                            <h4 style="font-size: 15px; font-weight: 700; color: var(--color-primary);"><%= item.getProductName() %></h4>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <span style="font-weight: 700; color: var(--color-primary);"><%= item.getSize() %></span>
                                </td>
                                <td>₹ <%= item.getPrice() %></td>
                                <td><%= item.getQuantity() %></td>
                                <td style="font-weight: 700; color: var(--color-primary);">₹ <%= item.getSubTotal() %></td>
                            </tr>
                        <%  }
                        } %>
                    </tbody>
                </table>
            </div>

            <!-- Shipping & Payment Recap -->
            <div>
                <div class="shipping-info-box" style="margin-bottom: 20px;">
                    <h4><i class="fa-solid fa-truck"></i> Shipping Information</h4>
                    <p><strong>Delivery Address:</strong><br><%= order.getShippingAddress() %></p>
                </div>

                <div class="shipping-info-box">
                    <h4><i class="fa-solid fa-credit-card"></i> Payment Summary</h4>
                    <p style="margin-bottom: 8px;"><strong>Payment Method:</strong> <%= order.getPaymentMethod() %></p>
                    <p style="margin-bottom: 8px;"><strong>Shipping Charges:</strong> <span style="color: var(--color-success); font-weight: 700;">FREE</span></p>
                    <div style="font-size: 20px; font-weight: 800; color: var(--color-primary); border-top: 1px dashed var(--color-border); padding-top: 12px; margin-top: 12px;">
                        <span>Total Paid:</span>
                        <span style="color: var(--color-accent); float: right;">₹ <%= String.format("%.2f", order.getTotalAmount()) %></span>
                    </div>
                </div>
            </div>
        </div>

        <div style="display: flex; gap: 14px; margin-top: 20px;">
            <a href="${pageContext.request.contextPath}/orders" class="btn btn-secondary">
                <i class="fa-solid fa-arrow-left"></i> Back to Orders
            </a>
            <button onclick="window.print()" class="btn btn-primary">
                <i class="fa-solid fa-print"></i> Print Invoice
            </button>
        </div>
    </div>
</div>

<%@ include file="partials/footer.jsp"%>

</body>
</html>
