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
String pcost = request.getParameter("pprice");
String purl = request.getParameter("purl");
String pdesc = request.getParameter("pdesc");

Double pprice = Double.parseDouble(pcost);

String sql1 = "Insert into product (productName, productPrice, productImageURL, productDesc) values (?, ?, ?, ?)";

try {

	getConnection();
    Statement stmt = con.createStatement();
	stmt.execute("USE orders");

    PreparedStatement pstmt = con.prepareStatement(sql1);
	pstmt.setString(1, pname);
    pstmt.setDouble(2, pprice);
    pstmt.setString(3, purl);
    pstmt.setString(4, pdesc);
	pstmt.executeUpdate();

    out.println("<h1>Product Inserted<h1>");
    out.println("<table border=\"1\">");

    out.println("<tr><th>Product Name</th><td>"+pname+"</td></tr>");
    out.println("<tr><th>Price</th><td>"+pprice+"</td></tr>");
    out.println("<tr><th>URL Name</th><td>"+purl+"</td></tr>");
    out.println("<tr><th>Description</th><td>"+pdesc+"</td></tr>");
    out.println("</table>");
}
catch(SQLException ex) {
	out.println(ex);
}
%>
<a href = "index.jsp">Home</a>

</body>
</html>
