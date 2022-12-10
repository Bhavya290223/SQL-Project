<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>
<h1>Administrator Sales Report by Day</h1>

<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp" %>
<%@ page import="java.text.NumberFormat" %>
<%
String username = (String) session.getAttribute("authenticatedUser");
%>
<%

// TODO: Write SQL query that prints out total order amount by day
String sql = "Select year(orderDate), month(orderDate), day(orderDate), sum(totalAmount) as total from OrderSummary group by year(orderDate), month(orderDate), day(orderDate)";

try {

	getConnection();
    Statement stmt = con.createStatement();
	stmt.execute("USE orders");

	ResultSet rst = stmt.executeQuery(sql);
    NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	out.println("<table border=\"1\"><tr><th>Order Date</th><th>Total Order Amount</th></tr>");
        
    while(rst.next()) {
		String OrderDate = rst.getInt(1) + " - " +  rst.getInt(2) + " - " + rst.getInt(3);
		out.println("<tr><td>" + OrderDate + "</td>");
		out.println("<td>" + currFormat.format(rst.getDouble(4)) + "</td>");
		out.println("</tr>");
	}
	out.println("</table>");
}
catch(SQLException ex) {
	out.println(ex);
}

%>
<a href = "newProd.jsp">Add new Product</a><br>
<a href = "delProd.jsp">Delete a Product</a><br>
<a href = "custInfo.jsp">List All Customers</a>
</body>
</html>

