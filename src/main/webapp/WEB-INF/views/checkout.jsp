<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fashionstore.model.CartView"%>
<%@ page import="com.fashionstore.model.User"%>

<%
User user = (User) session.getAttribute("loggedInUser");

List<CartView> cartItems =
        (List<CartView>) request.getAttribute("cartItems");

Double cartTotal =
        (Double) request.getAttribute("cartTotal");

if(cartTotal == null){
    cartTotal = 0.0;
}
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Checkout | Fashion Store</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/assets/css/style.css?v=2">

<link rel="stylesheet"
href="${pageContext.request.contextPath}/assets/css/checkout.css?v=2">

</head>

<body>

<%@ include file="partials/navbar.jsp"%>

<div class="container">

<h2 class="page-title">

Checkout

</h2>

<div class="checkout-container">

<!-- Customer Details -->

<div class="checkout-left">

<h3>

Shipping Details

</h3>

<form action="${pageContext.request.contextPath}/payment"
      method="post">

<div class="form-group">

<label>Full Name</label>

<input
type="text"
name="fullName"
value="<%=user.getFullName()%>"
readonly>

</div>

<div class="form-group">

<label>Email</label>

<input
type="email"
name="email"
value="<%=user.getEmail()%>"
readonly>

</div>

<div class="form-group">

<label>Phone</label>

<input
type="text"
name="phone"
value="<%=user.getPhone()%>"
readonly>

</div>

<div class="form-group">

<label>Address</label>

<textarea
name="address"
rows="3"
required><%=user.getAddress()%></textarea>

</div>

<div class="form-group">

<label>City</label>

<input
type="text"
name="city"
value="<%=user.getCity()%>"
required>

</div>

<div class="form-group">

<label>State</label>

<input
type="text"
name="state"
value="<%=user.getState()%>"
required>

</div>

<div class="form-group">

<label>Pincode</label>

<input
type="text"
name="pincode"
value="<%=user.getPincode()%>"
required>

</div>

<div class="form-group">

<label>Payment Method</label>

<select name="paymentMethod">

<option value="COD">
Cash On Delivery
</option>

<option value="UPI">
UPI
</option>

<option value="Card">
Debit / Credit Card
</option>

</select>

</div>

<button
type="submit"
class="btn">

Place Order

</button>

</form>

</div>

<!-- Order Summary -->

<div class="checkout-right">

<h3>

Order Summary

</h3>

<table class="summary-table">

<tr>

<th>Product</th>

<th>Qty</th>

<th>Price</th>

</tr>

<%
for(CartView item : cartItems){
%>

<tr>

<td>

<%=item.getProductName()%>

</td>

<td>

<%=item.getQuantity()%>

</td>

<td>

₹ <%=item.getSubTotal()%>

</td>

</tr>

<%
}
%>

<tr>

<th colspan="2">

Grand Total

</th>

<th>

₹ <%=cartTotal%>

</th>

</tr>

</table>

</div>

</div>

</div>

<%@ include file="partials/footer.jsp"%>

</body>

</html>