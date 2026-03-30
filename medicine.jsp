<%@ page import="java.sql.*" %>

<%
String med = request.getParameter("med");
String dosage = request.getParameter("dosage");
String time = request.getParameter("time");
String start = request.getParameter("start");
String end = request.getParameter("end");

Connection con = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/health_monitoring","root","naincy37");

    PreparedStatement ps = con.prepareStatement(
        "INSERT INTO medication(user_id,medicine_name,dosage,time,start_date,end_date) VALUES (?,?,?,?,?,?)");

    // ✅ get user from session
    int userId = (int) session.getAttribute("user_id");

    ps.setInt(1, userId);
    ps.setString(2, med);
    ps.setString(3, dosage);
    ps.setString(4, time);
    ps.setString(5, start);
    ps.setString(6, end);

    ps.executeUpdate();

    out.println("<h3>Medication Saved Successfully!</h3>");

} catch(Exception e){
    out.println(e);
}
%>