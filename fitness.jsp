<%@ page import="java.sql.*" %>

<%
int userId = (int) session.getAttribute("user_id");

// ======================
// 🔹 FETCH HEALTH DATA
// ======================
String weight="", height="", stepsData="", caloriesData="";

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/health_monitoring","root","naincy37");

    PreparedStatement ps1 = con.prepareStatement(
        "SELECT * FROM health_data WHERE user_id=? ORDER BY id DESC LIMIT 1");

    ps1.setInt(1, userId);
    ResultSet rs = ps1.executeQuery();

    if(rs.next()){
        weight = rs.getString("weight");
        height = rs.getString("height");
        stepsData = rs.getString("steps");
        caloriesData = rs.getString("calories");
    }

    // ======================
    // 🔹 INSERT FITNESS DATA
    // ======================

    String workout = request.getParameter("workout");

    if(workout != null){  // ✅ only run when form submitted

        String time = request.getParameter("time");
        String steps = request.getParameter("steps");
        String calories = request.getParameter("calories");
        String goal = request.getParameter("goal");
        String bmi = request.getParameter("bmi");

        PreparedStatement ps2 = con.prepareStatement(
            "INSERT INTO fitness(user_id,workout_type,workout_time,steps,calories_burned,step_goal,bmi,record_date) VALUES (?,?,?,?,?,?,?,CURDATE())");

        ps2.setInt(1, userId);
        ps2.setString(2, workout);
        ps2.setInt(3, Integer.parseInt(time));
        ps2.setInt(4, Integer.parseInt(steps));
        ps2.setInt(5, Integer.parseInt(calories));

        if(goal == null || goal.equals("")){
            ps2.setInt(6, 0);
        } else {
            ps2.setInt(6, Integer.parseInt(goal));
        }

        ps2.setDouble(7, Double.parseDouble(bmi));

        ps2.executeUpdate();

        out.println("<script>alert('Fitness Saved Successfully!');</script>");
    }

} catch(Exception e){
    out.println(e);
}
%>