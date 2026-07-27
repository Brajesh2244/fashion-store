<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Payment | Fashion Store</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/assets/css/style.css?v=2">

<link rel="stylesheet"
href="${pageContext.request.contextPath}/assets/css/payment.css?v=2">

</head>

<body>

<%@ include file="partials/navbar.jsp"%>

<div class="container">

    <h2 class="page-title">

        Payment

    </h2>

    <div class="payment-container">

        <form action="${pageContext.request.contextPath}/place-order"
              method="post">
              
            <!-- Hidden field to pass address from checkout to PlaceOrderServlet -->
            <input type="hidden" name="address" value="<%= request.getParameter("address") != null ? request.getParameter("address") : "" %>">

            <h3>Select Payment Method</h3>

            <div class="payment-option">

                <input
                        type="radio"
                        id="cod"
                        name="paymentMethod"
                        value="Cash On Delivery"
                        checked>

                <label for="cod">

                    Cash On Delivery

                </label>

            </div>

            <div class="payment-option">

                <input
                        type="radio"
                        id="upi"
                        name="paymentMethod"
                        value="UPI">

                <label for="upi">

                    UPI

                </label>

            </div>

            <div class="payment-option">

                <input
                        type="radio"
                        id="card"
                        name="paymentMethod"
                        value="Card">

                <label for="card">

                    Debit / Credit Card

                </label>

            </div>

            <div class="payment-option">

                <input
                        type="radio"
                        id="netbanking"
                        name="paymentMethod"
                        value="Net Banking">

                <label for="netbanking">

                    Net Banking

                </label>

            </div>

            <button
                    type="submit"
                    class="btn">

                Place Order

            </button>

        </form>

    </div>

</div>

<%@ include file="partials/footer.jsp"%>

</body>

</html>