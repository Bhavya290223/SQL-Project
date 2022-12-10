<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>El Siglo Nuevo's Grocery Order Processing</title>
</head>
<body>

<% 
// Get customer id
String custId = request.getParameter("customerId");
String pwd = request.getParameter("password");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Determine if valid customer id was entered
int num = -1;
//if (custId == null || custId.equals("") || pwd == null || pwd.equals("")) {
//	out.println("<h1>Invalid Customer Id or password. Please Try Again</h1>");
//} else if (productList == null) {
//	out.println("<h1>Your cart is empty!</h1>");
//} else {
//	//Check if customer id is a Number
//	try {
//		num = Integer.parseInt(custId);
//	}
//	catch(Exception e) {
//		out.println("<h1>Invalid Customer id or password. Please Try Again</h1>");
//	}
//}
// Determine if there are products in the shopping cart
// If either are not true, display an error message

String sql = "Select customerId, firstName + ' ' + lastName From customer where customerId = ? and password = ?";
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// Make connection
try {
	getConnection();
	Statement stmt = con.createStatement();
	stmt.execute("USE orders");

	if (custId == null || custId.equals("") || pwd == null || pwd.equals("")) {
		out.println("<h1>Invalid Customer Id or password. Please Try Again</h1>");
	} else if (productList == null) {
		out.println("<h1>Your cart is empty!</h1>");
	} else {
		//Check if customer id is a Number
		try {
			num = Integer.parseInt(custId);
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, pwd);
		}
		catch(Exception e) {
			out.println("<h1>Invalid Customer id or password. Please Try Again</h1>");
		}
	}
//	PreparedStatement pstmt = con.prepareStatement(sql);
//	pstmt.setInt(1, num);
//	pstmt.setString(2, pwd);
//	ResultSet rst = pstmt.executeQuery();


	int orderId = 0;
	String custName = "";
	double total = 0;

	if (!rst.next()) {
		out.println("<h1>Invalid Customer Id or password. Please Try again!</h1>");
	} else {
		custName = rst.getString(2);
		String sql1 = "Insert into OrderSummary (Customerid, totalAmount, orderDate) values (?, 0, ?)";
		
		PreparedStatement pstmt1 = con.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);
		pstmt1.setInt(1, num);
		Timestamp stamp = new java.sql.Timestamp(System.currentTimeMillis());
		Date date = new Date(stamp.getTime());
		pstmt1.setTimestamp(2, stamp);
		pstmt1.executeUpdate();
		ResultSet keys = pstmt1.getGeneratedKeys();
		keys.next();
		orderId = keys.getInt(1);

		out.println("<h1>Your Order Summary</h1>");
		out.println("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th></tr>");
		Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
		while (iterator.hasNext())
		{
			Map.Entry<String, ArrayList<Object>> entry = iterator.next();
			ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
			String productId = (String) product.get(0);
			String price = (String) product.get(2);
			double pr = Double.parseDouble(price);
			int qty = ( (Integer)product.get(3)).intValue();

			out.print("<tr><td>" + productId+ "</td>");
			out.print("<td>"+product.get(1)+"</td>");
			out.print("<td align=\"center\">"+product.get(3)+"</td>");
			out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
			out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td></tr>");
			total += pr*qty;
			
			String sql2 = "INSERT into OrderProduct (orderId, productId, quantity, price) values (?, ?, ?, ?)";
			PreparedStatement pstmt2 = con.prepareStatement(sql2);
			pstmt2.setInt(1, orderId);
			pstmt2.setInt(2, Integer.parseInt(productId));
			pstmt2.setInt(3, qty);
			pstmt2.setString(4, price);
		}
		out.println("<tr><td align = \"right\" colspan = \"4\"><b>Order Total</b></td><td align =\"right\">" + currFormat.format(total) + "</td></tr>");
		out.println("</table>");

		String sql3 = "Update OrderSummary set totalAmount=? where orderId= ?";
		PreparedStatement pstmt3 = con.prepareStatement(sql3);
		pstmt3.setDouble(1, total);
		pstmt3.setInt(2, orderId);
		pstmt3.executeUpdate();

		out.println("<h1>Order Completed. Will be shipped soon...</h1>");
		out.println("<h1>Your order reference number is: "+orderId+"</h1>");
		out.println("<h1>Shipping to customer: "+custId+" Name: "+custName+"</h1>");

		out.println("<h2><a href = \"shop.html\">Return to Shopping</a></h2>");

		session.setAttribute("productList", null);
	}
}
// Save order information to database


	/*
	// Use retrieval of auto-generated keys.
	PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);			
	ResultSet keys = pstmt.getGeneratedKeys();
	keys.next();
	int orderId = keys.getInt(1);
	*/

// Insert each item into OrderProduct table using OrderId from previous INSERT

// Update total amount for order record

// Here is the code to traverse through a HashMap
// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price

/*
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
		String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int qty = ( (Integer)product.get(3)).intValue();
			...
	}
*/

// Print out order summary

// Clear cart if order placed successfully

catch (SQLException ex) {
	out.println(ex);
}
%>
</BODY>
</HTML>

