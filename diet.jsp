<%@ page import="java.sql.*" %>

<%
String weight = request.getParameter("weight");
String height = request.getParameter("height");
String bmi = request.getParameter("bmi");

String dietType = request.getParameter("dietType");
String calories = request.getParameter("calories");
String protein = request.getParameter("protein");
String carbs = request.getParameter("carbs");
String fats = request.getParameter("fats");
String mealPlan = request.getParameter("mealPlan");

Connection con = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/health_monitoring","root","naincy37");

    PreparedStatement ps = con.prepareStatement(
        "INSERT INTO diet(user_id,weight,height,bmi,diet_type,calories,protein,carbs,fats,meal_plan,record_date) VALUES (?,?,?,?,?,?,?,?,?,?,CURDATE())");

    // 🔥 use session user_id (IMPORTANT)
    int userId = (int) session.getAttribute("user_id");

    ps.setInt(1, userId);
    ps.setString(2, weight);
    ps.setString(3, height);
    ps.setDouble(4, Double.parseDouble(bmi));
    ps.setString(5, diet_type);
    ps.setInt(6, Integer.parseInt(calories));
    ps.setString(7, protein);
    ps.setString(8, carbs);
    ps.setString(9, fats);
    ps.setString(10, mealPlan);

    ps.executeUpdate();

    out.println("<h3>Diet Plan Saved Successfully!</h3>");

} catch(Exception e){
    out.println(e);
}
%>