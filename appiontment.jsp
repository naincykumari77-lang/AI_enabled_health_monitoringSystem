<%@ page import="java.sql.*" %>

<%
String name = request.getParameter("name");
String age = request.getParameter("age");
String gender = request.getParameter("gender");
String contact = request.getParameter("contact");

String doctor = request.getParameter("doctor");
String specialization = request.getParameter("specialization");

String date = request.getParameter("date");
String time = request.getParameter("time");

String symptoms = request.getParameter("symptoms");
String mode = request.getParameter("mode");

// ✅ GET USER ID FROM SESSION
Integer userId = (Integer) session.getAttribute("user_id");

if(userId == null){
    response.sendRedirect("login.html");
    return;
}

Connection con = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/health_monitoring","root","naincy37");

    PreparedStatement ps = con.prepareStatement(
        "INSERT INTO appointments(user_id,patient_name,age,gender,contact,doctor_name,specialization,appointment_date,appointment_time,symptoms,mode) VALUES (?,?,?,?,?,?,?,?,?,?,?)");

    ps.setInt(1, userId); // ✅ FIXED
    ps.setString(2, name);
    ps.setInt(3, Integer.parseInt(age));
    ps.setString(4, gender);
    ps.setString(5, contact);
    ps.setString(6, doctor);
    ps.setString(7, specialization);
    ps.setString(8, date);
    ps.setString(9, time);
    ps.setString(10, symptoms);
    ps.setString(11, mode);

    ps.executeUpdate();

    out.println("<h3>Appointment Booked Successfully!</h3>");

} catch(Exception e){
    out.println(e);
}
%>