<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.fashionstore.model.User"%>

<%
User loggedInUser = (User) session.getAttribute("loggedInUser");
%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<nav class="navbar">

    <div class="logo">
        <a href="${pageContext.request.contextPath}/home">
            FashionStore
        </a>
    </div>

    <div class="search-bar">
        <form action="${pageContext.request.contextPath}/products" method="get">
            <input
                type="text"
                name="keyword"
                placeholder="Search products...">
        </form>
    </div>

    <ul class="nav-links">

        <li>
            <a href="${pageContext.request.contextPath}/home">
                Home
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/products">
                Products
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/cart">
                Cart
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/orders">
                Orders
            </a>
        </li>

        <%
        if(loggedInUser == null){
        %>

            <li>
                <a href="${pageContext.request.contextPath}/login">
                    Login
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/register">
                    Register
                </a>
            </li>

        <%
        } else {
        %>

            <li>

                <a href="${pageContext.request.contextPath}/profile">

                    Welcome,
                    <%=loggedInUser.getFullName()%>

                </a>

            </li>

            <li>

                <a href="${pageContext.request.contextPath}/logout">

                    Logout

                </a>

            </li>

        <%
        }
        %>

    </ul>

</nav>