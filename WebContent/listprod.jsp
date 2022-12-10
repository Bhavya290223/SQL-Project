<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>El Nuevo Siglo's Grocery</title>
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
	table{
        border: 5px solid;
        border-color: black;
        background-color: lightyellow;
    }
    td{
        border: 1.5px solid;
        padding: 15px 100px;
        font-size: 20px;
        font-family: Arial, Helvetica, sans-serif;
    }
    th{
        border: 1.5px solid;
        padding: 15px 100px;
        font-size: 35px;
        font-family: serif;
    }
  </style>
<body>
	<div class="wrap-flex">
		<h1 align="center" >El Nuevo Siglo Grocery</h1>
		<span style="padding: 0px 220px;"></span>
		<div align=" right">
			<a href="shop.html" class="button">Home</a>
			<a href="showcart.jsp" class="button">Shopping Cart</a>
			<a href="listorder.jsp" class="button">Orders</a>
	</div> </div>


<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
String name = request.getParameter("productName");
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!
try{
	getConnection();
	Statement stmt = con.createStatement();
	stmt.execute("USE orders");

	NumberFormat currFormat = NumberFormat.getCurrencyInstance();

	if(name == null){
		ResultSet rst = stmt.executeQuery("SELECT productId, productName, productPrice FROM product");
		out.println("<h2>All Products</h2>");
		out.println("<table><tr><th></th><th>Product Name</th><th>Price</th></tr>");
		while (rst.next()){
			while(rst.next()){
				int prodId = rst.getInt(1);
				String prodName = rst.getString(2);
				double prodPrice = rst.getDouble(3);
				out.println("<tr><td><a href=\"addcart.jsp?id=" + prodId + "&name=" + prodName + "&price=" + prodPrice + "\">Add to Cart</a></td>"+"<td><a href = \"product.jsp?id=" + prodId + "\">" + prodName + "</a></td><td>" + currFormat.format(prodPrice) + "</td></tr>");
			}
			out.println("</table>");
		}
	}else{
		String SQL = "SELECT productId, productName, productPrice FROM product WHERE productName LIKE '%' + ? + '%'";
		PreparedStatement pst = con.prepareStatement(SQL);
		pst.setString(1,name);
		
		ResultSet rst = pst.executeQuery();
		
		out.println("<h2>All Products</h2>");
		out.println("<table><tr><th></th><th>Product Name</th><th>Price</th></tr>");
			
		while(rst.next()){
			int prodId = rst.getInt(1);
			String prodName = rst.getString(2);
			double prodPrice = rst.getDouble(3);
			out.println("<tr><td><a href=\"addcart.jsp?id=" + prodId + "&name=" + prodName + "&price=" + prodPrice + "\">Add to Cart</a></td>+<td><a href = \"product.jsp?id=" + prodId + "\">" + prodName + "</a></td>" + "<td>" + currFormat.format(prodPrice) + "</td></tr>");
		}
		out.println("</table>");
	};
	
	
// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice

// Close connection
	closeConnection();

	} catch (SQLException ex){
		out.println(ex);
	}

%>

</body>
</html>