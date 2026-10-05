<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
String address = request.getParameter("address");
if (address == null || address.trim().isEmpty()) {
    // If accessed directly without address, fallback to checkout
    address = "Registered Address";
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Payment Method | FashionStore</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=3">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/cart.css?v=3">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/payment.css?v=3">
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
        <div class="step-item">
            <span class="step-num">2</span>
            <span>Shipping</span>
        </div>
        <div class="step-line"></div>
        <div class="step-item active">
            <span class="step-num">3</span>
            <span>Payment</span>
        </div>
    </div>

    <h1 class="page-title">Secure Payment</h1>

    <div class="payment-card">
        <h3><i class="fa-solid fa-credit-card"></i> Choose Payment Method</h3>

        <!-- Shipping Address Recap -->
        <div class="shipping-recap">
            <strong><i class="fa-solid fa-truck"></i> Delivering To:</strong>
            <span><%= address %></span>
        </div>

        <form action="${pageContext.request.contextPath}/place-order" method="post">
            <input type="hidden" name="address" value="<%= address %>">

            <div class="payment-options-list">
                <!-- UPI -->
                <label class="payment-choice" for="pay_upi">
                    <input type="radio" id="pay_upi" name="paymentMethod" value="UPI" checked>
                    <div class="payment-choice-info">
                        <span class="payment-title">Instant UPI (GPay, PhonePe, Paytm)</span>
                        <div class="payment-icons">
                            <i class="fa-solid fa-qrcode"></i>
                        </div>
                    </div>
                </label>

                <!-- Cards -->
                <label class="payment-choice" for="pay_card">
                    <input type="radio" id="pay_card" name="paymentMethod" value="Card">
                    <div class="payment-choice-info">
                        <span class="payment-title">Credit or Debit Card</span>
                        <div class="payment-icons">
                            <i class="fa-brands fa-cc-visa"></i>
                            <i class="fa-brands fa-cc-mastercard"></i>
                        </div>
                    </div>
                </label>

                <!-- Net Banking -->
                <label class="payment-choice" for="pay_nb">
                    <input type="radio" id="pay_nb" name="paymentMethod" value="Net Banking">
                    <div class="payment-choice-info">
                        <span class="payment-title">Internet Banking</span>
                        <div class="payment-icons">
                            <i class="fa-solid fa-building-columns"></i>
                        </div>
                    </div>
                </label>

                <!-- COD -->
                <label class="payment-choice" for="pay_cod">
                    <input type="radio" id="pay_cod" name="paymentMethod" value="Cash On Delivery">
                    <div class="payment-choice-info">
                        <span class="payment-title">Cash on Delivery (COD)</span>
                        <div class="payment-icons">
                            <i class="fa-solid fa-money-bill-wave"></i>
                        </div>
                    </div>
                </label>
            </div>

            <button type="submit" class="pay-btn">
                <i class="fa-solid fa-lock"></i> Authorize & Place Order
            </button>

            <div class="security-note">
                <i class="fa-solid fa-shield-halved"></i> 256-bit SSL Bank-Grade Encryption Guaranteed
            </div>
        </form>
    </div>
</div>

<%@ include file="partials/footer.jsp"%>

</body>
</html>