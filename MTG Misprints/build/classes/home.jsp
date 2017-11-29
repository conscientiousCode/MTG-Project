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
	<!-- TODO: fetch sample products via sql -->
	
	<h1>Sample Products</h1>
	
	<table>
		
		<!-- Some progress on jsp code -->
		<!--
		<%
			try {
				
				Connection con = CommonSQL.getDBConnection();
				PreparedStatement ps = con.prepareStatement("SELECT image, name, description FROM CardProduct ORDER BY price LIMIT 5");
				ps.execute();
				ResultSet rs = ps.getResultSet();
				
				while(rs.next()) {
					out.println("<tr>");
					out.println("<td style=\"width:150px; vertival-align:top;\">");
					//image from rs
					out.println("</td>");
					out.println("<td style=\"vertical-align:top;\">");
					//name and description from rs
					out.println("</td>");
					out.println("</tr>");
				}
				
			} catch(SQLException e) {
				e.printStackTrace();
			}
		%>
		-->
		
		<!-- Placeholder Static HTML for sample products -->
		<tr>
			<td style="width:150px; vertical-align:top;">
				<a href="product.jsp?id=1">
					<img src="res/card1.jpg" style="max-width:150px; max-height:150px; display: block; margin:auto;">
				</a>
			</td>
			<td style="vertical-align:top;">
				<a href="product.jsp?id=1"><b>CardProduct.name</b></a>
				<br>
				CardProduct.description
			</td>
		</tr>
		<tr>
			<td style="width:150px; vertical-align:top;">
				<a href="product.jsp?id=2">
					<img src="res/card2.jpg" style="max-width:150px; max-height:150px; display: block; margin:auto;">
				</a>
			</td>
			<td style="vertical-align:top;">
				<a href="product.jsp?id=2"><b>CardProduct.name</b></a>
				<br>
				CardProduct.description
			</td>
		</tr>
		
	</table>
	
</body>
</html>