<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Login | Fashion Store</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/assets/css/style.css?v=2">

<link rel="stylesheet"
href="${pageContext.request.contextPath}/assets/css/auth.css?v=2">

</head>

<body>

<%@ include file="partials/navbar.jsp"%>

<div class="auth-container">

    <div class="auth-card">

        <h2>Login To Your Account</h2>

        <%
        String error = (String) request.getAttribute("error");

        if(error != null){
        %>

        <p style="color:red;
                  text-align:center;
                  margin-bottom:15px;">

            <%=error%>

        </p>

        <%
        }
        %>

        <form action="${pageContext.request.contextPath}/login"
              method="post">

            <div class="form-group">

                <label>Email</label>

                <input
                    type="email"
                    name="email"
                    placeholder="Enter Email"
                    required>

            </div>

            <div class="form-group">

                <label>Password</label>

                <input
                    type="password"
                    name="password"
                    placeholder="Enter Password"
                    required>

            </div>

            <button
                type="submit"
                class="btn auth-btn">

                Login

            </button>

        </form>

        <p class="auth-link">

            Don't have an account?

            <a href="${pageContext.request.contextPath}/register">

                Register Here

            </a>

        </p>

    </div>

</div>

<%@ include file="partials/footer.jsp"%>

</body>

</html>