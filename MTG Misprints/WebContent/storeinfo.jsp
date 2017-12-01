<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="pageutils.*" %>
<%@ page import="dto.*" %>

<html>
<head>
	<title>Store Info</title>
</head>

<%
	if(session.getAttribute("user") == null) {
		response.sendRedirect("home.jsp");
		return;
	} else if(((User) session.getAttribute("user")).userGroup != User.GROUP_MERCHANT) {
		response.sendRedirect("accessdenied.jsp");
		return;
	}
%>

<body>
	
	<!-- WEBPAGE HEADER -->
	<%out.println(Header.getHeader((User)session.getAttribute("user")));%>
	
	<!-- WEBPAGE CONTENT -->
	
	<h1>Store Info</h1>
	
	<h2>Settings</h2>
	
	<table>
		<%
			try {
				Connection con = CommonSQL.getDBConnection();
				PreparedStatement ps = con.prepareStatement("SELECT merchantname, email FROM Merchant JOIN SiteUser ON Merchant.suid = SiteUser.suid AND Merchant.suid=?;");
				User user = (User) session.getAttribute("user");
				ps.setInt(1, user.suid);
				ps.execute();
				ResultSet rs = ps.getResultSet();
				if(rs.next()) {
					out.print("<tr><td><b>Name:</b></td><td>");
					out.print(rs.getString(1));
					out.println("</td></tr>");
					out.print("<tr><td><b>E-Mail:</b></td><td>");
					out.print(rs.getString(2));
					out.println("</td></tr>");
				}
			} catch(SQLException e) {
				out.println(e);
				e.printStackTrace();
			}
		%>
	</table>
	<h3><a href="settings.jsp">Modify</a></h3>
	
	<h2>Products</h2>
	
	<h3><a href="addproduct.jsp">Add Product</a></h3>
	
	<table>
		
		<%
			try {
				Connection con = CommonSQL.getDBConnection();
				PreparedStatement ps = con.prepareStatement("SELECT cardproductid, image, name, price, inventory, description FROM CardProduct WHERE merchantid=?;");
				User user = (User) session.getAttribute("user");
				ps.setInt(1, user.suid);
				ps.execute();
				out.println(CardInfo.getCardInfo(ps.getResultSet(), CardInfo.NAME, CardInfo.PRICE, CardInfo.INV, CardInfo.DESC));
				con.close();
			} catch(SQLException e) {
				out.println(e.toString());
				e.printStackTrace();
			}
		%>
		
	</table>
	
	<h3><a href="addproduct.jsp">Add Product</a></h3>
	
	<table>
	
		<tr><td colspan=2><h2>Pending Orders</h2></td></tr>
		
		<%
			try {
				Connection con = CommonSQL.getDBConnection();
				PreparedStatement ps1 = con.prepareStatement("SELECT InOrder.productorderid, InOrder.cardproductid, image, orderdate, name, quantity, description FROM InOrder, ProductOrder, CardProduct WHERE InOrder.productorderid=ProductOrder.productorderid AND InOrder.cardproductid=CardProduct.cardproductid AND merchantid=? AND shipdate IS NULL ORDER BY productorderid;");
				User user = (User) session.getAttribute("user");
				ps1.setInt(1, user.suid);
				ps1.execute();
				ResultSet rs = ps1.getResultSet();
				int id = 0;
				while(rs.next()) {
					if(rs.getInt(1) != id) {
						id = rs.getInt(1);
						out.println("<tr><td colspan=2>");
						out.println("<form method=get action=storeinfo.jsp>");
						out.print("<h3>Ordered On: ");
						out.print(rs.getString(4));
						out.println("<input type=\"submit\" value=\"Mark As Shipped\"></h3>");
						out.println("</form>");
						out.println("</td></tr>");
					}
					out.println("<tr><td style=\"width:150px; vertical-align:top;\">");
					out.print("<a href=\"product.jsp?id=");
					out.print(rs.getInt(2));
					out.print("\"><img src=");
					// TODO: image from database
					out.print(CommonSQL.getImageSourceForProduct(rs.getInt("cardproductid")));
					out.println(" style=\"max-width:150px; max-height:150px; display:block; margin:auto;\"></a>");
					out.println("</td>");
					out.println("<td style=\"vertical-align:top;\">");
					out.print("<a href=\"product.jsp?id=");
					out.print(rs.getInt(2));
					out.print("\"><b>");
					out.print(rs.getString(5));
					out.println("</b></a><br>");
					out.print("<b>Quantity: </b>");
					out.print(rs.getInt(6));
					out.println("<br>");
					out.print(rs.getString(7));
					out.println("</td></tr>");
				}
				con.close();
			} catch(SQLException e) {
				out.println(e);
				e.printStackTrace();
			}
		%>
		
		<tr><td colspan=2><h2>Shipped Orders</h2></td></tr>
		
		<%
			try {
				Connection con = CommonSQL.getDBConnection();
				PreparedStatement ps1 = con.prepareStatement("SELECT InOrder.productorderid, InOrder.cardproductid, image, shipdate, name, quantity, description FROM InOrder, ProductOrder, CardProduct WHERE InOrder.productorderid=ProductOrder.productorderid AND InOrder.cardproductid=CardProduct.cardproductid AND merchantid=? AND shipdate IS NOT NULL ORDER BY productorderid;");
				User user = (User) session.getAttribute("user");
				ps1.setInt(1, user.suid);
				ps1.execute();
				ResultSet rs = ps1.getResultSet();
				int id = 0;
				while(rs.next()) {
					if(rs.getInt(1) != id) {
						id = rs.getInt(1);
						out.println("<tr><td colspan=2>");
						out.println("<form method=get action=storeinfo.jsp>");
						out.print("<h3>Shipped On: ");
						out.print(rs.getString(4));
						out.println("<input type=\"submit\" value=\"Mark As Shipped\"></h3>");
						out.println("</form>");
						out.println("</td></tr>");
					}
					out.println("<tr><td style=\"width:150px; vertical-align:top;\">");
					out.print("<a href=\"product.jsp?id=");
					out.print(rs.getInt(2));
					out.print("\"><img src=");
					// TODO: image from database
					out.print(CommonSQL.getImageSourceForProduct(rs.getInt("cardproductid")));
					out.println("style=\"max-width:150px; max-height:150px; display:block; margin:auto;\"></a>");
					out.println("</td>");
					out.println("<td style=\"vertical-align:top;\">");
					out.print("<a href=\"product.jsp?id=");
					out.print(rs.getInt(2));
					out.print("\"><b>");
					out.print(rs.getString(5));
					out.println("</b></a><br>");
					out.print("<b>Quantity: </b>");
					out.print(rs.getInt(6));
					out.println("<br>");
					out.print(rs.getString(7));
					out.println("</td></tr>");
				}
				con.close();
			} catch(SQLException e) {
				out.println(e);
				e.printStackTrace();
			}
		%>
		
	</table>
	
</body>
</html>