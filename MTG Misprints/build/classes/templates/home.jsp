<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="pageutils.*" %>
<html>
<head>
	<title>MTG Misprints</title>
</head>
<body>

	<!-- WEBPAGE HEADER -->
	<!-- TODO: java for login/logout -->
	
	<table style="width:100%; padding:10px;">
		<tr>
			
			<!-- Logo -->
			<td style="width:33%; text-align:left;">
				<a href="home.jsp"><img src="res/Logo.png"></a>
			</td>
			
			<!-- Search Bar -->
			<td style="width:33%; text-align:center;">
				<b>Search Cards</b>
				<br>
				<form method=get action=searchresults.jsp>
					<input type="text" name="querry" size="20">
					<input type="submit" value="Search">
				</form>
				<a href="advancedsearch.jsp">Advanced Search</a>
			</td>
			
			<!-- Either login or logout widget -->
			
			<!-- Login -->
			<td style="width:33%; text-align:right;">
				<form method=post action=login.jsp>
					<input type="text" name="username" placeholder="Username" required><br>
					<input type="password" name="password" placeholder="Password" required><br>
					<input type="submit" value="Login">
				</form>
			</td>
			
			<!-- Logout -->
			<!--
			<td style="width:33%; text-align:right;">
				<a href="settings.jsp"><b>Jeff Thomson</b></a><br><br>
				<form method=get action=logout.jsp>
					<input type="submit" value="Logout">
				</form>
			</td>
			-->
			
		</tr>
	</table>
	
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
				<b>Price: </b> CardProduct.price
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
				<a href="product.jsp?id=2"><b>Wald Plains</b></a>
				<br>
				<b>Price: </b> $300.00
				<br>
				A Plains printed with it's name as "Wald", German for forest.
			</td>
		</tr>
		
	</table>
	
</body>
</html>