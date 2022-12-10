<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>El Nuevo Siglo Grocery Shipment Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>

<%

String ordId = request.getParameter("orderId");
try {
	if (ordId == null || ordId.equals("")) {
		out.println("<h1>Invalid Order Id</h1>");
	} else {
		getConnection();
		Statement st = con.createStatement(); 			
		st.execute("USE orders");
		
		String sql = "Select orderId, productId, quantity, price from orderproduct where orderId = ?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(ordId));
		ResultSet rst = pstmt.executeQuery();

		int orderId = 0;
		String cName = "";

		if (!rst.next()) {
			out.println("<h1>Invalid Order Id or no items in order</h1>");
		} else {
			try {
				con.setAutoCommit(false);

				String sql1 = "Insert into shipment (shipmentDate, warehouseId) values (?, 1)";
				pstmt = con.prepareStatement(sql1);
				pstmt.setTimestamp(1, new java.sql.Timestamp(new Date().getTime()));
				pstmt.executeUpdate();

				String sql2 = "Select quantity from productInventory where warehouseId = 1 and productId = ?";
				PreparedStatement pstmt1 = con.prepareStatement(sql2);
				boolean status = true;

				sql = "update productInventory set quantity = ? where productId = ? and warehouseId = 1";
				pstmt = con.prepareStatement(sql);

				while (rst.next()) {
					int prodId = rst.getInt(2);
					int qty = rst.getInt(3);
					pstmt1.setInt(1, prodId);
					ResultSet rst1 = pstmt1.executeQuery();

					if (!rst1.next() || rst1.getInt(1) < qty) {
						out.println("<h1>Shipment Not Done. Insufficient Inventory items</h1>");
						status = false;
						break;
					}

					int invQty = rst1.getInt(1);
					pstmt.setInt(1, invQty - qty);
					pstmt.setInt(2, prodId);
					pstmt.executeUpdate();

					out.println("<h2>Ordered Product: "+prodId+" Qty: "+qty+" Previous Qty: "+ (invQty - qty)+"</h2>");
				} 

				if (!status) {
					con.rollback();
				} else {
					con.commit();
					out.println("<h1>Shipment Successfully placed</h1>");
				}
				
			}catch (SQLException ex) {
				con.rollback();
				out.println(ex);
			} finally {
				con.setAutoCommit(true);
			}
		}
	}
	// TODO: Start a transaction (turn-off auto-commit)
	
	// TODO: Retrieve all items in order with given id
	// TODO: Create a new shipment record.
	// TODO: For each item verify sufficient quantity available in warehouse 1.
	// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
	
	// TODO: Auto-commit should be turned back on
}
catch (SQLException ex) {
	out.println(ex);
}
finally
{
	closeConnection();
}
%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>
