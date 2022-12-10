<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>El Siglo Nuevo's Grocery Order List</title>
</head>
<style>
	.wrap-flex { 
		display: flex;
		border: 5px solid blue ;
		background-color: lightgreen;
		
	}
	.button {
	  background-color: #ef7d3c;
	  border: none;
	  color: white;
	  padding: 20px 34px;
	  text-align: center;
	  text-decoration: none;
	  display: inline-block;
	  font-size: 20px;
	  margin: 4px 2px;
	  cursor: pointer;
	}
  </style>
<body>
	<div class="wrap-flex">
		<h1 align="center" >El Nuevo Siglo Grocery</h1>
		<span style="padding: 0px 220px;"></span>
		<div align=" right">
			<a href="shop.html" class="button">Home</a>
			<a href="listprod.jsp" class="button">Products</a>
			<a href="showcart.jsp" class="button">Shopping Cart</a>
	</div> </div>

<h1>Order List</h1>

<%
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

String sql = "Select orderId, O.CustomerId, totalAmount, firstName + ' ' + lastName from ordersummary O, customer C where O.customerId = C.customerId";
NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try {

	getConnection();
	Statement stmt = con.createStatement();
	stmt.execute("USE orders");

	ResultSet rst = stmt.executeQuery(sql);
	out.println("<table border=\"1\"><tr><th>Order Id</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr><tr></tr>");

	// Print out the order summary information
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times

	String sql2 = "Select productId, quantity, price from OrderProduct where orderId = ?";
	PreparedStatement pstmt = con.prepareStatement(sql2);

	// For each product in the order
		// Write out product information 
	
	while(rst.next()) {
		int orderId = rst.getInt(1);
		out.println("<tr><td>" + orderId + "</td>");
		out.println("<td>" + rst.getString(4) + "</td>");
		out.println("<td>" + rst.getInt(2) + "</td>");
		out.println("<td>" + rst.getString(4) + "</td>");
		out.println("<td>" + currFormat.format(rst.getDouble(3)) + "</td>");
		out.println("</tr>");

		pstmt.setInt(1, orderId);
		ResultSet rst2 = pstmt.executeQuery();
		out.println("<tr align=\"right\"><td colspan=\"4\"><table border=\"1\"><tr><th>Product Id</th><th>Quantity</th><th>Price</th></tr>");
		while(rst2.next()) {
			out.print("<tr><td>" + rst2.getInt(1) + "</td>");
			out.print("<td>" + rst2.getInt(2) + "</td>");
			out.print("<td>" + currFormat.format(rst.getDouble(3)) + "</td></tr>");
		}
		out.println("</table></td></tr>");
	}
	out.println("</table>");
}
catch(SQLException ex) {
	out.println(ex);
}
%>

</body>
</html>

