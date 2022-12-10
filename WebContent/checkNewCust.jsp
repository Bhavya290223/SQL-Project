<!DOCTYPE html>
<html>
<head>
<title>Create Account Page</title>
</head>
<body>
<h1>Add New Customer</h1>
<%@ include file="jdbc.jsp" %>
<%
// TODO: Write SQL query that prints out total order amount by day
String fname = request.getParameter("fname");
String lname = request.getParameter("lname");
String email = request.getParameter("email");
String phone = request.getParameter("num");
String address = request.getParameter("address");
String city = request.getParameter("city");
String state = request.getParameter("state");
String postal = request.getParameter("psc");
String country = request.getParameter("country");
String username = request.getParameter("user");
String password = request.getParameter("pass");

String sql1 = "Insert into customer values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

try {

	getConnection();
    Statement stmt = con.createStatement();
	stmt.execute("USE orders");

    PreparedStatement pstmt = con.prepareStatement(sql1);
	pstmt.setString(1, fname);
    pstmt.setString(2, lname);
    pstmt.setString(3, email);
    pstmt.setString(4, phone);
    pstmt.setString(5, address);
    pstmt.setString(6, city);
    pstmt.setString(7, state);
    pstmt.setString(8, postal);
    pstmt.setString(9, country);
    pstmt.setString(10, username);
    pstmt.setString(11, password);
	pstmt.executeUpdate();

    out.println("<h1>Customer Added<h1>");
    out.println("<table border=\"1\">");
    out.println("<tr><th>First Name</th><td>"+fname+"</td></tr>");
    out.println("<tr><th>Last Name</th><td>"+lname+"</td></tr>");
    out.println("<tr><th>Email</th><td>"+email+"</td></tr>");
    out.println("<tr><th>Phone Number</th><td>"+phone+"</td></tr>");
    out.println("<tr><th>Address</th><td>"+address+"</td></tr>");
    out.println("<tr><th>City</th><td>"+city+"</td></tr>");
    out.println("<tr><th>State</th><td>"+state+"</td></tr>");
    out.println("<tr><th>Postal Code</th><td>"+postal+"</td></tr>");
    out.println("<tr><th>Country</th><td>"+country+"</td></tr>");
    out.println("<tr><th>User Id</th><td>"+username+"</td></tr>");
    out.println("</table>");
}
catch(SQLException ex) {
	out.println(ex);
}
%>
<a href = "index.jsp">Home</a>

</body>
</html>
