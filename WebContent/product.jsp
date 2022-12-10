<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>ENS's Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>
<%@ include file="auth.jsp" %>
<%@ page import="java.text.NumberFormat" %>
<%
String username = (String) session.getAttribute("authenticatedUser");
%>

<%
// Get product name to search for
// TODO: Retrieve and display info for the product

String productId = request.getParameter("id");
String comm = request.getParameter("review");
String ratings = request.getParameter("rati");

String sql = "Select * from Product where productId = ?";
NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try 
{
	getConnection();
	Statement st = con.createStatement(); 			
	st.execute("USE orders");

	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setInt(1,Integer.parseInt(productId));
	ResultSet rst = pstmt.executeQuery();
	
	if (!rst.next()) {
		out.println("Invalid product");
	} else {
		out.println("<h2>"+rst.getString(2)+"</h2>");

		int pId = rst.getInt(1);
		out.println("<table><tr>");
		out.println("<th>Id</th><td>"+pId+"</td></tr> + <tr><th>Price</th><td>" + currFormat.format(rst.getDouble(3))+ "</td></tr>");
		String imgUrl = rst.getString(4);
		if (imgUrl != null) {
			out.println("<img src =\""+imgUrl+"\">");
		}

		String imgDB = rst.getString(5);
		if (imgDB != null) {
			out.println("<img src =\"displayImage.jsp?id="+pId+"\">");
		}
		out.println("</table>");

		String prodName = rst.getString(2);
		Double prodPrice = rst.getDouble(3);
		out.println("<h3><a href=\"addcart.jsp?id=" + pId + "&name=" + prodName + "&price=" + prodPrice + "\">Add to Cart</a></h3>");
		out.println("<h3><a href = \"listprod.jsp\">Continue Shopping</a></h3>");
%>
		<form name="MyForm" method=post action="product.jsp">
			<table style="display:inline">
			<tr>
				<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Enter Product Rating:</font></div></td>
				<td><input type="number" name="rati"  size=10 maxlength=40 min="1" max="5"></td>
			</tr>
			<tr>
				<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Enter Product Review:</font></div></td>
				<td><textarea id="text" name="review" rows="4" cols="50"></textarea></td>
			</tr>
			</table>
			<br/>
			<input class="submit" type="submit" name="Submit2" value="Send">
		</form>
		<%

		String sql1 = "Insert into review (?, ?, ?, ?, ?)";
		String sql2 = "Select customerId from customer where userid = ?";

		PreparedStatement pstmt1 = con.prepareStatement(sql2);
		pstmt1.setString(1,username);
		ResultSet rst1 = pstmt1.executeQuery();

		int custId = 0;
		if (rst1.next()) {
			custId = rst1.getInt(1);
		}

		pstmt1 = con.prepareStatement(sql1);
		pstmt1.setInt(1,Integer.parseInt(ratings));
		Timestamp stamp = new java.sql.Timestamp(System.currentTimeMillis());
		Date date = new Date(stamp.getTime());
		pstmt1.setTimestamp(2, stamp);
		pstmt1.setInt(3, custId);
		pstmt1.setInt(4, Integer.parseInt(productId));
		pstmt1.setString(5, comm);
		pstmt1.executeUpdate();

	}
} 
catch (SQLException ex) {
	out.println(ex);
}
finally
{
	closeConnection();
}

// TODO: If there is a productImageURL, display using IMG tag
		
// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
		
// TODO: Add links to Add to Cart and Continue Shopping
%>

</body>
</html>

