<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<html>
<head>
	<title>CardProduct.cardname</title>
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
	
	<h1>CardProduct.cardname</h1>
	
	<table>
		
		<tr>
			<td style="width:150px; vertical-align:top;">
				<a href="product.jsp?id=1">
					<img src="res/card1.jpg" style="max-width:150px; max-height:150px; display: block; margin:auto;">
				</a>
			</td>
			<td style="vertical-align:top;">
				<b>Name: </b> CardProduct.name
				<br>
				<b>Price: </b> CardProduct.price
				<br>
				<b>Inventory: </b> CardProduct.inventory
				<br>
				<b>Merchant: </b> Merchant.merchantname
				<br>
				<b>Tags: </b>
				<a href="searchresults.jsp?tag=CardAttribute.name">CartAttribute.name</a>, 
				<a href="searchresults.jsp?tag=CardAttribute.name">CartAttribute.name</a>,
				<a href="searchresults.jsp?tag=CardAttribute.name">CartAttribute.name</a>
				<br>
				CardProduct.description
			</td>
		</tr>
		
	</table>
	
</body>
</html>