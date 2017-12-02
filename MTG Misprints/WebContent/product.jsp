<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="pageutils.*" %>
<%@ page import="dto.*" %>

<%
	String p = request.getParameter("id");
	if(p == null) {
		response.sendRedirect("advancedsearch.jsp");
		return;
	}
	int id = Integer.parseInt(p);
	String name = "";
	try {
		Connection con = CommonSQL.getDBConnection();
		PreparedStatement ps = con.prepareStatement("SELECT name FROM CardProduct WHERE cardproductid=?");
		ps.setInt(1, id);
		ps.execute();
		ResultSet rs = ps.getResultSet();
		if(rs.next()) {
			name = rs.getString(1);
		}
		con.close();
	} catch(SQLException e) {
		e.printStackTrace();
	}
%>

<html>
<head>
	<title><% out.println(name); %></title>
</head>
<body>
	
	<!-- WEBPAGE HEADER -->
	<%out.println(Header.getHeader((User)session.getAttribute("user"), (Cart)session.getAttribute("cart")));%>
	
	<!-- WEBPAGE CONTENT -->
	
	<h1><% out.print(name); %></h1>
	
	<%
		if(session.getAttribute("cart") != null) {
			out.print("<form method=post action=addtocart.jsp?id=");
			out.print(id);
			out.println(">");
			out.println("<input type=submit value=\"Add To Cart\">");
			out.println("</form>");
		}
	%>
	
	<table>
		
		<tr>
		<%
			try {
				Connection con = CommonSQL.getDBConnection();
				PreparedStatement ps1 = con.prepareStatement("SELECT image, CardProduct.name, price, inventory, merchantname, CardAttribute.name, CardProduct.description FROM CardProduct, CardAttribute, HasAttribute, Merchant WHERE CardProduct.merchantid=Merchant.suid AND CardProduct.cardproductid=HasAttribute.cardproductid AND HasAttribute.cardattributeid=CardAttribute.cardattributeid AND CardProduct.cardproductid=?;");
				ps1.setInt(1, id);
				ps1.execute();
				ResultSet rs = ps1.getResultSet();
				if(rs.next()) {
					out.println("<td style=\"width:150px; vertical-align:top;\">");
					out.print("<a href=\"product.jsp?id=");
					out.print(id);
					out.print("\"><img src=");
					out.print(CommonSQL.getImageSourceForProduct(id));
					out.println(" style=\"max-width:150px; max-height:150px; display:block; margin:auto;\"></a>");
					out.println("</td>");
					out.println("<td style=\"vertical-align:top;\">");
					out.print("<b>Name: </b>");
					out.println(rs.getString(2));
					out.print("<br><b>Price: </b>$");
					out.println(rs.getString(3));
					out.print("<br><b>Inventory: </b>");
					out.println(rs.getInt(4));
					out.print("<br><b>Merchant: </b>");
					out.println(rs.getString(5));
					out.println("<br><b>Tags: </b>");
					String description = rs.getString(7);
					do {
						String attribute = rs.getString(6);
						out.print("<a href=\"searchresults.jsp?"+attribute+"=" + attribute);
						out.print(attribute);
						out.print("\">");
						out.print(attribute);
						out.println("</a>");
					} while(rs.next());
					out.println("<br>");
					out.println(description);
				} else {
					PreparedStatement ps2 = con.prepareStatement("SELECT image, CardProduct.name, price, inventory, merchantname, CardProduct.description FROM CardProduct, Merchant WHERE CardProduct.merchantid=Merchant.suid AND CardProduct.cardproductid=?;");
					ps2.setInt(1, id);
					ps2.execute();
					ResultSet rs2 = ps2.getResultSet();
					if(rs2.next()) {
						out.println("<td style=\"width:150px; vertical-align:top;\">");
						out.print("<a href=\"product.jsp?id=");
						out.print(id);
						out.print("\"><img src=");
						out.print(CommonSQL.getImageSourceForProduct(id));
						out.println(" style=\"max-width:150px; max-height:150px; display:block; margin:auto;\"></a>");
						out.println("</td>");
						out.println("<td style=\"vertical-align:top;\">");
						out.print("<b>Name: </b>");
						out.println(rs2.getString(2));
						out.print("<br><b>Price: </b>$");
						out.println(rs2.getString(3));
						out.print("<br><b>Inventory: </b>");
						out.println(rs2.getInt(4));
						out.print("<br><b>Merchant: </b>");
						out.println(rs2.getString(5));
						out.println("<br>");
						out.println(rs2.getString(6));
					}
				}
				con.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
			out.println("</td>");
		%>
		</tr>
		
	</table>
	
	<%
		if(session.getAttribute("cart") != null) {
			out.print("<form method=post action=addtocart.jsp?id=");
			out.print(id);
			out.println(">");
			out.println("<input type=submit value=\"Add To Cart\">");
			out.println("</form>");
		}
	%>
	
</body>
</html>