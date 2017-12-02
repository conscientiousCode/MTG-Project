<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="pageutils.*" %>
<%@ page import="dto.*" %>
<html>
<head>
	<title>My Orders</title>
</head>
<body>
	
	<!-- WEBPAGE HEADER -->
	<% out.println(Header.getHeader((User)session.getAttribute("user"), (Cart)session.getAttribute("cart"))); 
		User user = (User) session.getAttribute("user");
		if(user == null || user.userGroup != User.GROUP_CUSTOMER){
			response.sendRedirect("home.jsp");
			return;
		}
	%>
	
	<!-- WEBPAGE CONTENT -->
	
	<h1>My Orders</h1>
	
	<table>
	
		<tr><td colspan=2><h2>Pending Orders</h2></td></tr>
		
		<%
			try {
				Connection con = CommonSQL.getDBConnection();
				PreparedStatement ps1 = con.prepareStatement("SELECT InOrder.productorderid, InOrder.cardproductid, image, orderdate, name, quantity, description FROM InOrder, ProductOrder, CardProduct WHERE InOrder.productorderid=ProductOrder.productorderid AND InOrder.cardproductid=CardProduct.cardproductid AND custid=? AND shipdate IS NULL ORDER BY productorderid;");
				
				ps1.setInt(1, user.suid);
				ps1.execute();
				ResultSet rs = ps1.getResultSet();
				int id = 0;
				while(rs.next()) {
					if(rs.getInt(1) != id) {
						id = rs.getInt(1);
						out.println("<tr><td colspan=2>");
						out.print("<h3>Ordered On: ");
						out.print(rs.getString(4));
						out.println("</td></tr>");
					}
					out.println("<tr><td style=\"width:150px; vertical-align:top;\">");
					out.print("<a href=\"product.jsp?id=");
					out.print(rs.getInt(2));
					out.print("\"><img src=");
					
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
				e.printStackTrace();
			}
		%>
		
		<tr><td colspan=2><h2>Shipped Orders</h2></td></tr>
		
		<%
			try {
				Connection con = CommonSQL.getDBConnection();
				PreparedStatement ps1 = con.prepareStatement("SELECT InOrder.productorderid, InOrder.cardproductid, image, shipdate, name, quantity, description FROM InOrder, ProductOrder, CardProduct WHERE InOrder.productorderid=ProductOrder.productorderid AND InOrder.cardproductid=CardProduct.cardproductid AND custid=? AND shipdate IS NOT NULL ORDER BY productorderid;");
				ps1.setInt(1, user.suid);
				ps1.execute();
				ResultSet rs = ps1.getResultSet();
				int id = 0;
				while(rs.next()) {
					if(rs.getInt(1) != id) {
						id = rs.getInt(1);
						out.println("<tr><td colspan=2>");
						out.print("<h3>Shipped On: ");
						out.print(rs.getString(4));
						out.println("</td></tr>");
					}
					out.println("<tr><td style=\"width:150px; vertical-align:top;\">");
					out.print("<a href=\"product.jsp?id=");
					out.print(rs.getInt(2));
					out.print("\"><img src=");
					
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
				e.printStackTrace();
			}
		%>
		
	</table>
	
</body>
</html>