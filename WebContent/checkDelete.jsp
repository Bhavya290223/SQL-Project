<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>
<h1>Add New Product</h1>
<br>
<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.NumberFormat" %>
<%
String username = (String) session.getAttribute("authenticatedUser");
%>

<%

// TODO: Write SQL query that prints out total order amount by day
String pname = request.getParameter("pname");

String sql1 = "Delete from product where productName = ?";

try {

	getConnection();
    Statement stmt = con.createStatement();
	stmt.execute("USE orders");

    PreparedStatement pstmt = con.prepareStatement(sql1);
	pstmt.setString(1, pname);
	pstmt.executeUpdate();

    out.println("<h1>Product Deleted<h1>");
    out.println("<table border=\"1\">");

    out.println("<tr><th>Product Name</th><td>"+pname+"</td></tr>");
    out.println("</table>");
}
catch(SQLException ex) {
	out.println(ex);
}
%>
<a href = "index.jsp">Home</a>

</body>
</html>
