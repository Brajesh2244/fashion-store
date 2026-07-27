<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Register | Fashion Store</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/assets/css/style.css?v=2">

<link rel="stylesheet"
href="${pageContext.request.contextPath}/assets/css/auth.css?v=2">

</head>

<body>

<%@ include file="partials/navbar.jsp"%>

<div class="auth-container">

    <div class="auth-card">

        <h2>Create Your Account</h2>

        <form action="${pageContext.request.contextPath}/register"
              method="post">

            <div class="form-group">

                <label>Full Name</label>

                <input
                    type="text"
                    name="fullName"
                    placeholder="Enter your full name"
                    required>

            </div>

            <div class="form-group">

                <label>Email</label>

                <input
                    type="email"
                    name="email"
                    placeholder="Enter your email"
                    required>

            </div>

            <div class="form-group">

                <label>Phone</label>

                <input
                    type="text"
                    name="phone"
                    placeholder="Enter your phone number"
                    required>

            </div>

            <div class="form-group">

                <label>Password</label>

                <input
                    type="password"
                    name="password"
                    placeholder="Create password"
                    required>

            </div>

            <div class="form-group">

                <label>Address</label>

                <textarea
                    name="address"
                    rows="3"
                    placeholder="Enter your address"
                    required></textarea>

            </div>

            <div class="row">

                <div class="form-group">

                    <label>City</label>

                    <input
                        type="text"
                        name="city"
                        required>

                </div>

                <div class="form-group">

                    <label>State</label>

                    <input
                        type="text"
                        name="state"
                        required>

                </div>

            </div>

            <div class="form-group">

                <label>Pincode</label>

                <input
                    type="text"
                    name="pincode"
                    required>

            </div>

            <button
                type="submit"
                class="btn auth-btn">

                Register

            </button>

        </form>

        <p class="auth-link">

            Already have an account?

            <a href="${pageContext.request.contextPath}/login">

                Login Here

            </a>

        </p>

    </div>

</div>

<%@ include file="partials/footer.jsp"%>

</body>

</html>