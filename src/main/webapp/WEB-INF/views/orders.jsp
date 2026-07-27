<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fashionstore.model.Order"%>

<%
List<Order> orders =
        (List<Order>) request.getAttribute("orders");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>My Orders | Fashion Store</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/assets/css/style.css?v=2">

<link rel="stylesheet"
href="${pageContext.request.contextPath}/assets/css/orders.css?v=2">

</head>

<body>

<%@ include file="partials/navbar.jsp"%>

<div class="container">

<h2 class="page-title">

My Orders

</h2>

<%
if(orders == null || orders.isEmpty()){
%>

<div class="empty-orders">

<h3>

No Orders Found

</h3>

<p>

You haven't placed any orders yet.

</p>

<a
href="${pageContext.request.contextPath}/products"
class="btn">

Start Shopping

</a>

</div>

<%
}else{
%>

<table class="orders-table">

<thead>

<tr>

<th>Order ID</th>

<th>Order Date</th>

<th>Total Amount</th>

<th>Payment</th>

<th>Status</th>
<th>Action</th>
</tr>

</thead>

<tbody>

<%
for(Order order : orders){
%>

<tr>

<td>

#<%=order.getOrderId()%>

</td>

<td>

<%=order.getOrderDate()%>

</td>

<td>

₹ <%=order.getTotalAmount()%>

</td>

<td>

<%=order.getPaymentMethod()%>

</td>

<td>
<span class="status">
<%=order.getStatus()%>
</span>
</td>
<td>
<a href="${pageContext.request.contextPath}/order-details?orderId=<%=order.getOrderId()%>" class="btn" style="padding: 6px 12px; font-size: 13px;">View Details</a>
</td>

</tr>

<%
}
%>

</tbody>

</table>

<%
}
%>

</div>

<%@ include file="partials/footer.jsp"%>

</body>

</html>