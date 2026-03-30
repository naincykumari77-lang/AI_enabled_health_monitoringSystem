<%@ page language="java" %>
<%
session.invalidate();
response.sendRedirect("login.html");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logged Out</title>
<link rel="stylesheet" href="style.css">
</head>

<body>

<div class="center-box">
    <div class="box">
        <h2>You are logged out</h2>
        <p>Thank you for using the system</p>

        <a href="login.jsp">Login Again</a>
    </div>
</div>

</body>
</html>