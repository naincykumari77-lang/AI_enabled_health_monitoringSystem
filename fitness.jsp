<%@ page import="java.sql.*" %>

<%
int userId = (int) session.getAttribute("user_id");

String weight="", height="", steps="", calories="";

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/health_monitoring","root","naincy37");

    PreparedStatement ps = con.prepareStatement(
        "SELECT * FROM health_data WHERE user_id=? ORDER BY id DESC LIMIT 1");

    ps.setInt(1, userId);

    ResultSet rs = ps.executeQuery();

    if(rs.next()){
        weight = rs.getString("weight");
        height = rs.getString("height");
        steps = rs.getString("steps");
        calories = rs.getString("calories");
    }

} catch(Exception e){
    out.println(e);
}
%>
<%@ page import="java.sql.*" %>

<%
String workout = request.getParameter("workout");
String time = request.getParameter("time");
String steps = request.getParameter("steps");
String calories = request.getParameter("calories");
String goal = request.getParameter("goal");
String bmi = request.getParameter("bmi");

Connection con = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/health_monitoring","root","naincy37");

    PreparedStatement ps = con.prepareStatement(
        "INSERT INTO fitness(user_id,workout_type,workout_time,steps,calories_burned,step_goal,bmi,record_date) VALUES (?,?,?,?,?,?,?,CURDATE())");

    // ✅ get user from session
    int userId = (int) session.getAttribute("user_id");

    ps.setInt(1, userId);
    ps.setString(2, workout);
    ps.setInt(3, Integer.parseInt(time));
    ps.setInt(4, Integer.parseInt(steps));
    ps.setInt(5, Integer.parseInt(calories));

    // optional goal handling
    if(goal == null || goal.equals("")){
        ps.setInt(6, 0);
    } else {
        ps.setInt(6, Integer.parseInt(goal));
    }

    ps.setDouble(7, Double.parseDouble(bmi));

    ps.executeUpdate();

    out.println("<h3>Fitness Data Saved Successfully!</h3>");

} catch(Exception e){
    out.println(e);
}
%>