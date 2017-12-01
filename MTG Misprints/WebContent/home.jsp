<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="pageutils.*" %>
<%@ page import="dto.*" %>
<html>
<head>
	<title>MTG Misprints</title>
</head>
<body>

<%
	out.println(Header.getHeader((User)session.getAttribute("user")));
%>	
	
	<!-- WEBPAGE CONTENT -->
	
	<h1>Sample Products</h1>
	
	<table>
		
		<%
			try {
				
				Connection con = CommonSQL.getDBConnection();
				PreparedStatement ps = con.prepareStatement("SELECT cardproductid, name, price, description FROM CardProduct ORDER BY price DESC LIMIT 8");
				ps.execute();
				ResultSet rs = ps.getResultSet();
				
				while(rs.next()) {
					out.println("<tr><td style=\"width:150px; vertival-align:top;\">");
					out.print("<a href=\"product.jsp?id=");
					out.print(rs.getInt(1));
					out.println("\">");
					out.print("<img src=");
					out.print(CommonSQL.getImageSourceForProduct(rs.getInt(1)));
					out.print(" style=\"max-width:150px; max-height:150px; display:block; margin:auto;\">");
					out.println("</a>");
					out.println("</td>");
					out.println("<td style=\"vertical-align:top;\">");
					out.print("<a href=\"product.jsp?id=");
					out.print(rs.getInt(1));
					out.print("\"><b>");
					out.print(rs.getString(2));
					out.println("</b></a><br>");
					out.print("<b>Price: </b>$");
					out.print(rs.getString(3));
					out.println("<br>");
					out.println(rs.getString(4));
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