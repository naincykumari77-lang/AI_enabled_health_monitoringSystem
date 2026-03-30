<%@ page import="java.sql.*" %>

<%
String name = request.getParameter("name");
String username = request.getParameter("username");
String email = request.getParameter("email");
String password = request.getParameter("password");

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/health_monitoring","root","naincy37");

    PreparedStatement ps = con.prepareStatement(
        "INSERT INTO users(full_name, username, email, password) VALUES (?, ?, ?, ?)");

    ps.setString(1, name);
    ps.setString(2, username);
    ps.setString(3, email);
    ps.setString(4, password);

    int i = ps.executeUpdate();

    if(i > 0){
        out.println("<h3>Registration Successful!</h3>");
        out.println("<a href='login.html'>Go to Login</a>");
    }

} catch(Exception e){
    out.println(e);
}
%>