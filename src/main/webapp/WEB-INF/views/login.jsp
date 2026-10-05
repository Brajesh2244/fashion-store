<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In | FashionStore</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=3">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth.css?v=3">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<%@ include file="partials/navbar.jsp"%>

<div class="container auth-container">
    <div class="auth-card">
        <div class="auth-brand-logo">
            <div class="auth-brand-icon">
                <i class="fa-solid fa-lock"></i>
            </div>
            <h2>Welcome Back</h2>
            <p class="auth-subtitle">Sign in with your registered account credentials</p>
        </div>

        <% if(error != null && !error.isEmpty()) { %>
            <div class="auth-error-banner">
                <i class="fa-solid fa-circle-exclamation"></i>
                <span><%= error %></span>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="auth-input-group">
                <label>Email Address</label>
                <div class="input-with-icon">
                    <i class="fa-regular fa-envelope"></i>
                    <input type="email" name="email" placeholder="name@example.com" required autocomplete="email">
                </div>
            </div>

            <div class="auth-input-group">
                <label>Password</label>
                <div class="input-with-icon">
                    <i class="fa-solid fa-key"></i>
                    <input type="password" name="password" placeholder="Enter password" required autocomplete="current-password">
                </div>
            </div>

            <button type="submit" class="auth-submit-btn">
                <span>Sign In to Account</span>
                <i class="fa-solid fa-arrow-right"></i>
            </button>
        </form>

        <div class="auth-footer-nav">
            Don't have an account? <a href="${pageContext.request.contextPath}/register">Create New Account</a>
        </div>
    </div>
</div>

<%@ include file="partials/footer.jsp"%>

</body>
</html>