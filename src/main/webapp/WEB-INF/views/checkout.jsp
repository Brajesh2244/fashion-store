<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fashionstore.model.CartView"%>
<%@ page import="com.fashionstore.model.User"%>

<%
User user = (User) session.getAttribute("loggedInUser");
if (user == null) {
    response.sendRedirect(request.getContextPath() + "/login");
    return;
}

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
    <title>Checkout | FashionStore</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=3">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/cart.css?v=3">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/checkout.css?v=3">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<%@ include file="partials/navbar.jsp"%>

<div class="container">
    <!-- Step Indicator -->
    <div class="checkout-steps">
        <div class="step-item">
            <span class="step-num">1</span>
            <span>Shopping Cart</span>
        </div>
        <div class="step-line"></div>
        <div class="step-item active">
            <span class="step-num">2</span>
            <span>Shipping</span>
        </div>
        <div class="step-line"></div>
        <div class="step-item">
            <span class="step-num">3</span>
            <span>Payment</span>
        </div>
    </div>

    <h1 class="page-title">Shipping & Delivery</h1>

    <div class="checkout-container">
        <!-- Shipping Details Form -->
        <div class="checkout-card">
            <h3><i class="fa-solid fa-location-dot"></i> Delivery Address</h3>

            <form action="${pageContext.request.contextPath}/payment" method="post" id="shippingForm">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="fullName" value="<%= user.getFullName() %>" required>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Email Address</label>
                        <input type="email" name="email" value="<%= user.getEmail() %>" readonly>
                    </div>

                    <div class="form-group">
                        <label>Mobile Number</label>
                        <input type="text" name="phone" value="<%= user.getPhone() != null ? user.getPhone() : "" %>" required>
                    </div>
                </div>

                <div class="form-group">
                    <label>Street Address / Flat / Landmark</label>
                    <textarea name="streetAddress" rows="3" required placeholder="House number, apartment name, street area"><%= user.getAddress() != null ? user.getAddress() : "" %></textarea>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>City</label>
                        <input type="text" name="city" value="<%= user.getCity() != null ? user.getCity() : "" %>" required placeholder="City">
                    </div>

                    <div class="form-group">
                        <label>State</label>
                        <input type="text" name="state" value="<%= user.getState() != null ? user.getState() : "" %>" required placeholder="State">
                    </div>
                </div>

                <div class="form-group">
                    <label>Postal PIN Code</label>
                    <input type="text" name="pincode" value="<%= user.getPincode() != null ? user.getPincode() : "" %>" required placeholder="PIN Code">
                </div>

                <!-- Hidden consolidated address to ensure complete delivery info carries through to payment -->
                <input type="hidden" name="address" id="fullAddressField">

                <button type="submit" class="checkout-btn">
                    <span>Continue to Payment</span>
                    <i class="fa-solid fa-arrow-right"></i>
                </button>
            </form>
        </div>

        <!-- Order Summary Card -->
        <div class="checkout-summary-card">
            <h3><i class="fa-solid fa-receipt"></i> Order Summary</h3>

            <div class="summary-items-list">
                <% if(cartItems != null) {
                    for(CartView item : cartItems) {
                %>
                    <div class="summary-item-row">
                        <div>
                            <div class="summary-item-name"><%= item.getProductName() %></div>
                            <div class="summary-item-meta">Size: <%= item.getSize() %> | Qty: <%= item.getQuantity() %></div>
                        </div>
                        <div style="font-weight: 700; color: var(--color-primary);">
                            ₹ <%= item.getSubTotal() %>
                        </div>
                    </div>
                <%  }
                } %>
            </div>

            <div class="summary-row">
                <span>Subtotal</span>
                <span>₹ <%= String.format("%.2f", cartTotal) %></span>
            </div>

            <div class="summary-row">
                <span>Delivery</span>
                <span style="color: var(--color-success); font-weight: 700;">FREE</span>
            </div>

            <div class="summary-row total-row">
                <span>Grand Total</span>
                <span class="total-amount">₹ <%= String.format("%.2f", cartTotal) %></span>
            </div>
        </div>
    </div>
</div>

<script>
document.getElementById('shippingForm').addEventListener('submit', function(e) {
    var street = this.streetAddress.value.trim();
    var city = this.city.value.trim();
    var state = this.state.value.trim();
    var pin = this.pincode.value.trim();
    document.getElementById('fullAddressField').value = street + ', ' + city + ', ' + state + ' - ' + pin;
});
</script>

<%@ include file="partials/footer.jsp"%>

</body>
</html>