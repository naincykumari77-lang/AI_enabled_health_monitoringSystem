<%@ page import="java.sql.*" %>

<%
String hr = request.getParameter("hr");
String bp = request.getParameter("bp");
String steps = request.getParameter("steps");
String cal = request.getParameter("cal");

Connection con = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/health_monitoring","root","naincy37");

    PreparedStatement ps = con.prepareStatement(
        "INSERT INTO health_data(user_id,heart_rate,blood_pressure,steps,calories,record_date) VALUES (?,?,?,?,?,CURDATE())");

    // ✅ get logged-in user
    int userId = (int) session.getAttribute("user_id");

    ps.setInt(1, userId);
    ps.setInt(2, Integer.parseInt(hr));
    ps.setString(3, bp);
    ps.setInt(4, Integer.parseInt(steps));
    ps.setInt(5, Integer.parseInt(cal));

    ps.executeUpdate();

    out.println("<h3>Health Data Saved Successfully!</h3>");

} catch(Exception e){
    out.println(e);
}
%>