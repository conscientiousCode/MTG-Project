<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<html>
<head>
	<title>Advanced Search</title>
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
	
	<h1>Advanced Search</h1>
	
	<form>
	
		<b>Product Name</b><br>
		<input type="text" name="productname" size=30><br>
		<br>
		
		<b>Cart Attributes</b><br>
		<input type="checkbox" name="attribute1">attribute1<br>
		<input type="checkbox" name="attribute2">attribute2<br>
		<input type="checkbox" name="attribute3">attribute3<br>
		<input type="checkbox" name="misprint">Misprint<br>
		<input type="checkbox" name="foreignlanguage">Foreign Language<br>
		<br>
		
		<input type="submit" value="Advanced Search">
		
		
	</form>
	
</body>
</html>