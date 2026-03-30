<%
String user = request.getParameter("username");
String pass = request.getParameter("password");

// simple demo login
if(user.equals("admin") && pass.equals("123")){

    session.setAttribute("user", user);
    response.sendRedirect("index.jsp");

}else{
%>

<script>
alert("Invalid login!");
window.location="login.jsp";
</script>

<%
}
%>