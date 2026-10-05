<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.fashionstore.model.User"%>

<%
User user = (User) request.getAttribute("user");
if (user == null) {
    user = (User) session.getAttribute("loggedInUser");
}
if (user == null) {
    response.sendRedirect(request.getContextPath() + "/login");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile | FashionStore</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=3">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/profile.css?v=3">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<%@ include file="partials/navbar.jsp"%>

<div class="container">
    <h1 class="page-title">Account Settings</h1>

    <div class="profile-card">
        <div class="profile-header">
            <div class="profile-avatar-circle">
                <i class="fa-solid fa-user"></i>
            </div>
            <h3><%= user.getFullName() %></h3>
            <p><i class="fa-regular fa-envelope"></i> <%= user.getEmail() %></p>
        </div>

        <form action="${pageContext.request.contextPath}/update-profile" method="post">
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="fullName" value="<%= user.getFullName() %>" readonly style="opacity: 0.8; cursor: not-allowed;">
            </div>

            <div class="profile-grid-row">
                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" name="email" value="<%= user.getEmail() %>" readonly style="opacity: 0.8; cursor: not-allowed;">
                </div>

                <div class="form-group">
                    <label>Phone Number</label>
                    <input type="text" name="phone" value="<%= user.getPhone() != null ? user.getPhone() : "" %>" required>
                </div>
            </div>

            <div class="form-group">
                <label>Default Street Address</label>
                <input type="text" name="address" value="<%= user.getAddress() != null ? user.getAddress() : "" %>" placeholder="Flat, House no., Building, Street">
            </div>

            <div class="profile-grid-row">
                <div class="form-group">
                    <label>City</label>
                    <input type="text" name="city" value="<%= user.getCity() != null ? user.getCity() : "" %>" placeholder="City">
                </div>

                <div class="form-group">
                    <label>State</label>
                    <input type="text" name="state" value="<%= user.getState() != null ? user.getState() : "" %>" placeholder="State">
                </div>
            </div>

            <div class="form-group">
                <label>PIN Code</label>
                <input type="text" name="pincode" value="<%= user.getPincode() != null ? user.getPincode() : "" %>" placeholder="6-digit PIN code">
            </div>

            <button type="submit" class="save-profile-btn">
                <i class="fa-solid fa-floppy-disk"></i> Update Profile Details
            </button>
        </form>
    </div>
</div>

<%@ include file="partials/footer.jsp"%>

</body>
</html>