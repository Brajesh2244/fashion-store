<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account | FashionStore</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=3">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth.css?v=3">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<%@ include file="partials/navbar.jsp"%>

<div class="container auth-container">
    <div class="auth-card register-card">
        <div class="auth-brand-logo">
            <div class="auth-brand-icon">
                <i class="fa-solid fa-user-plus"></i>
            </div>
            <h2>Create Your Account</h2>
            <p class="auth-subtitle">Join FashionStore for personalized collections and fast ordering</p>
        </div>

        <% if(error != null && !error.isEmpty()) { %>
            <div class="auth-error-banner">
                <i class="fa-solid fa-circle-exclamation"></i>
                <span><%= error %></span>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="auth-grid">
                <div class="auth-input-group">
                    <label>Full Name</label>
                    <div class="input-with-icon">
                        <i class="fa-regular fa-user"></i>
                        <input type="text" name="fullName" placeholder="Your name" required>
                    </div>
                </div>

                <div class="auth-input-group">
                    <label>Phone Number</label>
                    <div class="input-with-icon">
                        <i class="fa-solid fa-phone"></i>
                        <input type="text" name="phone" placeholder="Mobile number" required>
                    </div>
                </div>
            </div>

            <div class="auth-grid">
                <div class="auth-input-group">
                    <label>Email Address</label>
                    <div class="input-with-icon">
                        <i class="fa-regular fa-envelope"></i>
                        <input type="email" name="email" placeholder="name@example.com" required>
                    </div>
                </div>

                <div class="auth-input-group">
                    <label>Password</label>
                    <div class="input-with-icon">
                        <i class="fa-solid fa-key"></i>
                        <input type="password" name="password" placeholder="Create a password" required>
                    </div>
                </div>
            </div>

            <div class="auth-input-group">
                <label>Default Street Address</label>
                <div class="input-with-icon">
                    <i class="fa-solid fa-house"></i>
                    <input type="text" name="address" placeholder="Flat, building, area" required>
                </div>
            </div>

            <div class="auth-grid">
                <div class="auth-input-group">
                    <label>City</label>
                    <div class="input-with-icon">
                        <i class="fa-solid fa-city"></i>
                        <input type="text" name="city" placeholder="City" required>
                    </div>
                </div>

                <div class="auth-input-group">
                    <label>State</label>
                    <div class="input-with-icon">
                        <i class="fa-solid fa-map-location-dot"></i>
                        <input type="text" name="state" placeholder="State" required>
                    </div>
                </div>
            </div>

            <div class="auth-input-group">
                <label>PIN Code</label>
                <div class="input-with-icon">
                    <i class="fa-solid fa-location-pin"></i>
                    <input type="text" name="pincode" placeholder="6-digit Postal PIN Code" required>
                </div>
            </div>

            <button type="submit" class="auth-submit-btn">
                <span>Complete Registration</span>
                <i class="fa-solid fa-arrow-right"></i>
            </button>
        </form>

        <div class="auth-footer-nav">
            Already have an account? <a href="${pageContext.request.contextPath}/login">Sign In Here</a>
        </div>
    </div>
</div>

<%@ include file="partials/footer.jsp"%>

</body>
</html>