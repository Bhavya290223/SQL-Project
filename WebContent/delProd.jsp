<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>
<h1>Delete Product</h1>
<br>
<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp" %>
<%@ page import="java.text.NumberFormat" %>
<%
String username = (String) session.getAttribute("authenticatedUser");
%>
<form name="MyForm" method=post action="checkDelete.jsp">
    <table style="display:inline">
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Enter Product Name:</font></div></td>
        <td><input type="text" name="pname"  size=10 maxlength=40></td>
    </tr>
    </table>
    <br/>
    <input class="submit" type="submit" name="Submit2" value="Delete">
</form>

<!-- <%

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

%> -->

</body>
</html>