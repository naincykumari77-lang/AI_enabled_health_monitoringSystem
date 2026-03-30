<%@ page language="java" %>

<%
String user = (String) session.getAttribute("username");

if(user == null){
    response.sendRedirect("login.html");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Dashboard</title>

<style>
body {
    font-family: 'Segoe UI';
    background: #f4f6f9;
    margin: 0;
    padding: 20px;
}

/* Welcome Card */
.welcome-box {
    background: linear-gradient(135deg, #1abc9c, #2c3e50);
    color: white;
    padding: 30px;
    border-radius: 12px;
    text-align: center;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

.welcome-box h1 {
    margin: 0;
    font-size: 28px;
}

.welcome-box p {
    margin-top: 10px;
    font-size: 16px;
    opacity: 0.9;
}
</style>

</head>

<body>

<div class="welcome-box">
    <h1>Welcome, <%= user %> 👋</h1>
    <p>Thank you for logging into your AI Urban Health Monitoring System.</p>
    <p>Stay consistent, stay healthy 💙</p>
</div>

</body>
</html>