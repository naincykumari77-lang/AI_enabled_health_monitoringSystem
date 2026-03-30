<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String user = (String) session.getAttribute("username");
Integer userId = (Integer) session.getAttribute("user_id");

if(user == null){
    response.sendRedirect("login.html");
    return;
}

// DEFAULT VALUES
String hr="--", bp="--", steps="--", cal="--";
String dietType="No Diet", fitness="No Data";
String medicine="No Medication", medTime="--";
String appointment="No Appointment";

Connection con = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/health_monitoring","root","naincy37");

    // 🔹 HEALTH
    PreparedStatement ps1 = con.prepareStatement(
        "SELECT * FROM health_data WHERE user_id=? ORDER BY record_date DESC LIMIT 1");
    ps1.setInt(1, userId);
    ResultSet rs1 = ps1.executeQuery();

    if(rs1.next()){
        hr = rs1.getString("heart_rate");
        bp = rs1.getString("blood_pressure");
        steps = rs1.getString("steps");
        cal = rs1.getString("calories");
    }

    // 🔹 DIET (only type)
    PreparedStatement ps2 = con.prepareStatement(
        "SELECT diet_type FROM diet WHERE user_id=? ORDER BY record_date DESC LIMIT 1");
    ps2.setInt(1, userId);
    ResultSet rs2 = ps2.executeQuery();

    if(rs2.next()){
        dietType = rs2.getString("diet_type");
    }

    // 🔹 FITNESS
    PreparedStatement ps3 = con.prepareStatement(
        "SELECT steps FROM fitness WHERE user_id=? ORDER BY record_date DESC LIMIT 1");
    ps3.setInt(1, userId);
    ResultSet rs3 = ps3.executeQuery();

    if(rs3.next()){
        fitness = "Steps: " + rs3.getString("steps");
    }

    // 🔹 MEDICATION
    PreparedStatement ps4 = con.prepareStatement(
        "SELECT medicine_name,time FROM medication WHERE user_id=? ORDER BY start_date DESC LIMIT 1");
    ps4.setInt(1, userId);
    ResultSet rs4 = ps4.executeQuery();

    if(rs4.next()){
        medicine = rs4.getString("medicine_name");
        medTime = rs4.getString("time");
    }

    // 🔹 APPOINTMENT
    PreparedStatement ps5 = con.prepareStatement(
        "SELECT doctor_name,appointment_date FROM appointments WHERE user_id=? ORDER BY appointment_date DESC LIMIT 1");
    ps5.setInt(1, userId);
    ResultSet rs5 = ps5.executeQuery();

    if(rs5.next()){
        appointment = rs5.getString("doctor_name") + " on " + rs5.getString("appointment_date");
    }

} catch(Exception e){
    out.println(e);
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
<title>Dashboard</title>

<style>
body { font-family:'Segoe UI'; background:#f4f6f9; margin:0; padding:20px; }

.header {
    background:#2c3e50;
    color:white;
    padding:15px;
    border-radius:10px;
}

.cards {
    display:grid;
    grid-template-columns:repeat(4,1fr);
    gap:15px;
    margin-top:20px;
}

.card {
    background:white;
    padding:20px;
    border-radius:10px;
    box-shadow:0 3px 10px rgba(0,0,0,0.05);
}

.section {
    margin-top:20px;
}
body { 
    font-family:'Segoe UI'; 
    background:#f4f6f9; 
    margin:0; 
    padding:20px; 
}

/* CARD */
.card {
    background:white;
    padding:20px;
    border-radius:12px;
    margin-bottom:20px;
    box-shadow:0 3px 10px rgba(0,0,0,0.08);
}

/* GRID CARDS */
.cards {
    display:grid;
    grid-template-columns:repeat(4,1fr);
    gap:15px;
}

/* 🔥 FIXED CALENDAR */
#calendar {
    display:grid;
    grid-template-columns:repeat(7, 1fr); /* 7 days week */
    gap:10px;
    margin-top:10px;
}

/* DAY BOX */
.day {
    padding:15px;
    background:#e0e0e0;
    border-radius:8px;
    text-align:center;
    font-size:14px;
    font-weight:bold;
    transition:0.3s;
}

/* ACTIVE DAY */
.day.active {
    background:#4caf50;
    color:white;
    transform:scale(1.05);
}
</style>

</head>

<body>

<div class="header">
    <h2>Welcome <%= user %> 👋</h2>
</div>

<!-- HEALTH -->
<div class="cards">
    <div class="card">Heart Rate<br><b><%= hr %></b></div>
    <div class="card">BP<br><b><%= bp %></b></div>
    <div class="card">Steps<br><b><%= steps %></b></div>
    <div class="card">Calories<br><b><%= cal %></b></div>
</div>

<!-- DIET -->
<div class="card section">
    <h3>Diet Plan</h3>
    <p><b><%= dietType %></b></p>
</div>

<!-- FITNESS -->
<div class="card">
    <h3>Fitness</h3>
    <p><%= fitness %></p>
</div>

<!-- MEDICATION -->
<div class="card">
    <h3>Medication Reminder</h3>
    <p><b><%= medicine %></b> at <%= medTime %></p>
</div>

<!-- APPOINTMENT -->
<div class="card">
    <h3>Upcoming Appointment</h3>
    <p><%= appointment %></p>
</div>

<!-- CALENDAR -->
<div class="card">
<h3>Activity</h3>
<div id="calendar"></div>
</div>

<script src="dashboard.js"></script>

</body>
</html>