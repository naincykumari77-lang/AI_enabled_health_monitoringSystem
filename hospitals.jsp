<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
int userId = (int) session.getAttribute("user_id");
String lat = request.getParameter("lat");
String lon = request.getParameter("lon");

try {
    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/health_monitoring","root","naincy37");

    PreparedStatement ps = con.prepareStatement(
        "INSERT INTO hospital_search(user_id,latitude,longitude,search_time) VALUES (?,?,?,NOW())");

    ps.setInt(1, userId);
    ps.setString(2, lat);
    ps.setString(3, lon);

    ps.executeUpdate();

} catch(Exception e){
    out.println(e);
}
%>