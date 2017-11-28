<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<html>
<head>
	<title>Search Results</title>
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
				<b>USERNAME</b>
				<br>
				<form method=get action=settings.jsp>
					<input type="button" value="Settings">
				</form>
				<form method=get action=logout.jsp>
					<input type="submit" value="Logout">
				</form>
			</td>
			-->
			
		</tr>
	</table>
	
	<!-- WEBPAGE CONTENT -->
	<!-- TODO: fetch sample products via sql -->
	
	<h1>Search Results</h1>
	<a href="advancedsearch.jsp">Refine Search</a>
	
	<table>
		
		<!-- Some progress on jsp code -->
		<!--
		<%
			// Error when connecting states that no suitable driver is found.
			String url = "jdbc:mysql://cosc304.ok.ubc.ca/group2";
			String uid = "group2";
			String pw = "group2";
			try {
				
				Connection con = DriverManager.getConnection(url, uid, pw);
				PreparedStatement ps = con.prepareStatement("SELECT image, name, description FROM CardProduct ORDER BY ? LIMIT ? OFFSET ?");
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