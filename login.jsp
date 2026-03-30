<%@ page import="java.sql.*" %>

<%
String username = request.getParameter("username");
String password = request.getParameter("password");

try {
    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/health_monitoring","root","naincy37");

    PreparedStatement ps = con.prepareStatement(
        "SELECT * FROM users WHERE username=? AND password=?");

    ps.setString(1, username);
    ps.setString(2, password);

    ResultSet rs = ps.executeQuery();

    if(rs.next()){

        session.setAttribute("user_id", rs.getInt("user_id"));
        session.setAttribute("username", rs.getString("username"));

        out.println("<h3>Login Successful!</h3>");
        out.println("<a href='index.html'>Go to Dashboard</a>");

        // OR use redirect:
        response.sendRedirect("dashboard.jsp");

    } else {

        out.println("<h3>Invalid Username or Password!</h3>");
        out.println("<a href='login.html'>Try Again</a>");

    }

} catch(Exception e){
    out.println(e);
}
%>