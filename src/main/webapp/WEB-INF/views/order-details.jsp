<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fashionstore.model.Order"%>
<%@ page import="com.fashionstore.model.OrderItemView"%>

<%
Order order = (Order) request.getAttribute("order");
List<OrderItemView> orderItems = (List<OrderItemView>) request.getAttribute("orderItems");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Details | Fashion Store</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=2">
<style>
.order-details-container {
    width: 90%;
    margin: 30px auto;
    background: #fff;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.05);
}
.order-header {
    display: flex;
    justify-content: space-between;
    border-bottom: 1px solid #e5e7eb;
    padding-bottom: 20px;
    margin-bottom: 20px;
}
.order-items-table {
    width: 100%;
    border-collapse: collapse;
}
.order-items-table th, .order-items-table td {
    padding: 15px;
    text-align: left;
    border-bottom: 1px solid #f3f4f6;
}
.order-items-table th {
    background: #f8fafc;
    color: #4b5563;
}
.product-cell {
    display: flex;
    align-items: center;
    gap: 15px;
}
.product-cell img {
    width: 60px;
    height: 60px;
    object-fit: cover;
    border-radius: 8px;
}
.product-info h4 {
    margin-bottom: 5px;
    color: #1f2937;
}
.product-info p {
    font-size: 13px;
    color: #6b7280;
}
</style>
</head>
<body>

<%@ include file="partials/navbar.jsp"%>

<div class="container">
    <h2 class="page-title">Order #<%=order.getOrderId()%> Details</h2>
    
    <div class="order-details-container">
        <div class="order-header">
            <div>
                <p><strong>Order Date:</strong> <%=order.getOrderDate()%></p>
                <p><strong>Status:</strong> <%=order.getStatus()%></p>
            </div>
            <div>
                <p><strong>Payment Method:</strong> <%=order.getPaymentMethod()%></p>
                <p><strong>Shipping Address:</strong> <%=order.getShippingAddress()%></p>
            </div>
            <div>
                <p><strong>Total Amount:</strong> ₹ <%=order.getTotalAmount()%></p>
            </div>
        </div>
        
        <table class="order-items-table">
            <thead>
                <tr>
                    <th>Product</th>
                    <th>Size</th>
                    <th>Price</th>
                    <th>Qty</th>
                    <th>Subtotal</th>
                </tr>
            </thead>
            <tbody>
                <% for(OrderItemView item : orderItems) { %>
                <tr>
                    <td>
                        <div class="product-cell">
                            <img src="${pageContext.request.contextPath}/assets/images/no-image.png" alt="<%=item.getProductName()%>">
                            <div class="product-info">
                                <h4><%=item.getProductName()%></h4>
                                <p><%=item.getBrand()%></p>
                            </div>
                        </div>
                    </td>
                    <td><%=item.getSize()%></td>
                    <td>₹ <%=item.getPrice()%></td>
                    <td><%=item.getQuantity()%></td>
                    <td>₹ <%=item.getSubTotal()%></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        
        <div style="margin-top: 30px;">
            <a href="${pageContext.request.contextPath}/orders" class="btn">Back to Orders</a>
        </div>
    </div>
</div>

<%@ include file="partials/footer.jsp"%>

</body>
</html>
