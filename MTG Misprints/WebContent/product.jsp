<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="pageutils.*" %>
<%@ page import="dto.*" %>

<%
	int id = Integer.parseInt(request.getParameter("id"));
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
	<%out.println(Header.getHeader((User)session.getAttribute("user")));%>
	
	<!-- WEBPAGE CONTENT -->
	
	<h1>CardProduct.cardname</h1>
	
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
					//TODO: image
					out.print("\"><img src=\"res/");
					out.print("cardnoimage.png\"");
					out.println("style=\"max-width:150px; max-height:150px; display:block; margin:auto;\"></a>");
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
						out.print("<a href=\"searchresults.jsp?tag=");
						out.print(attribute);
						out.print("\">");
						out.print(attribute);
						out.println("</a>");
					} while(rs.next());
					out.println("<br>");
					out.println(description);
				}
			} catch(SQLException e) {
				e.printStackTrace();
			}
			out.println("</td>");
		%>
		</tr>
		
	</table>
	
</body>
</html>