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
<html>

<head>

<meta charset="UTF-8">

<title>Shopping Cart | Fashion Store</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/assets/css/style.css?v=2">

<link rel="stylesheet"
href="${pageContext.request.contextPath}/assets/css/cart.css?v=2">

</head>

<body>

<%@ include file="partials/navbar.jsp"%>

<div class="container">

    <h2 class="page-title">

        My Shopping Cart

    </h2>

<%
if(cartItems == null || cartItems.isEmpty()){
%>

    <div class="empty-cart">

        <h3>Your Cart is Empty</h3>

        <p>Add some products to your shopping cart.</p>

        <a href="${pageContext.request.contextPath}/products"
           class="btn">

            Continue Shopping

        </a>

    </div>

<%
}else{
%>

<table class="cart-table">

<thead>

<tr>

<th>Image</th>

<th>Product</th>

<th>Brand</th>

<th>Size</th>

<th>Price</th>

<th>Quantity</th>

<th>Subtotal</th>

<th>Action</th>

</tr>

</thead>

<tbody>

<%
for(CartView item : cartItems){
%>

<tr>

<td>

<img
src="${pageContext.request.contextPath}/<%=item.getImageUrl()%>"
class="cart-image"
alt="<%=item.getProductName()%>">

</td>

<td>

<%=item.getProductName()%>

</td>

<td>

<%=item.getBrand()%>

</td>

<td>

<%=item.getSize()%>

</td>

<td>

₹ <%=item.getPrice()%>

</td>

<td>

<form action="${pageContext.request.contextPath}/update-cart"
      method="post">

<input
type="hidden"
name="cartItemId"
value="<%=item.getCartItemId()%>">

<input
type="number"
name="quantity"
value="<%=item.getQuantity()%>"
min="1"
class="qty-input">

<button
type="submit"
class="btn">

Update

</button>

</form>

</td>

<td>

₹ <%=item.getSubTotal()%>

</td>

<td>

<a
href="${pageContext.request.contextPath}/remove-cart-item?id=<%=item.getCartItemId()%>"
class="remove-btn">

Remove

</a>

</td>

</tr>

<%
}
%>

</tbody>

</table>

<div class="cart-summary">

<h3>

Grand Total :
₹ <%=cartTotal%>

</h3>

<div class="cart-buttons">

<a
href="${pageContext.request.contextPath}/products"
class="btn">

Continue Shopping

</a>

<a
href="${pageContext.request.contextPath}/checkout"
class="btn">

Proceed To Checkout

</a>

</div>

</div>

<%
}
%>

</div>

<%@ include file="partials/footer.jsp"%>

</body>

</html>
