<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.fashionstore.model.User"%>

<%
User user = (User) request.getAttribute("user");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>My Profile | Fashion Store</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/assets/css/style.css?v=2">

<link rel="stylesheet"
href="${pageContext.request.contextPath}/assets/css/profile.css?v=2">

</head>

<body>

<%@ include file="partials/navbar.jsp"%>

<div class="container">

<h2 class="page-title">

My Profile

</h2>

<div class="profile-container">

<form action="${pageContext.request.contextPath}/update-profile"
      method="post">

<div class="form-group">

<label>Full Name</label>

<input
type="text"
name="fullName"
value="<%=user.getFullName()%>"
readonly>

</div>

<div class="form-group">

<label>Email</label>

<input
type="email"
name="email"
value="<%=user.getEmail()%>"
readonly>

</div>

<div class="form-group">

<label>Phone</label>

<input
type="text"
name="phone"
value="<%=user.getPhone()%>"
required>

</div>

<div class="form-group">

<label>Address</label>

<textarea
name="address"
rows="3"
required><%=user.getAddress()%></textarea>

</div>

<div class="form-group">

<label>City</label>

<input
type="text"
name="city"
value="<%=user.getCity()%>"
required>

</div>

<div class="form-group">

<label>State</label>

<input
type="text"
name="state"
value="<%=user.getState()%>"
required>

</div>

<div class="form-group">

<label>Pincode</label>

<input
type="text"
name="pincode"
value="<%=user.getPincode()%>"
required>

</div>

<button
type="submit"
class="btn">

Update Profile

</button>

</form>

</div>

</div>

<%@ include file="partials/footer.jsp"%>

</body>

</html>