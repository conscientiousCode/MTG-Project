<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<html>
<head>
	<title>My Orders</title>
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
			<!--
			<td style="width:33%; text-align:right;">
				<form method=post action=login.jsp>
					<input type="text" name="username" placeholder="Username" required><br>
					<input type="password" name="password" placeholder="Password" required><br>
					<input type="submit" value="Login">
				</form>
			</td>
			-->
			
			<!-- Logout -->
			<td style="width:33%; text-align:right;">
				<a href="settings.jsp"><b>Jeff Thomson</b></a><br><br>
				<form method=get action=logout.jsp>
					<input type="submit" value="Logout">
				</form>
			</td>
			
		</tr>
	</table>
	
	<!-- WEBPAGE CONTENT -->
	
	<h1>My Orders</h1>
	
	<h2>Pending Orders</h2>
	
	<table>
		
		<tr><td colspan=2><h3>Ordered On ProductOrder.orderdate</h3></td></tr>
		<tr>
			<td style="width:150px; vertical-align:top;">
				<a href="product.jsp?id=1">
					<img src="res/card1.jpg" style="max-width:150px; max-height:150px; display: block; margin:auto;">
				</a>
			</td>
			<td style="vertical-align:top;">
				<a href="product.jsp?id=1"><b>CardProduct.name</b></a>
				<br>
				<b>Quantity: </b> ProductOrder.quantity
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
				<b>Quantity: </b> 4
				<br>
				A Plains printed with it's name as "Wald", German for forest.
			</td>
		</tr>
		
		<tr><td colspan=2><h3>Ordered On 11/30/17</h3></td></tr>
		<tr>
			<td style="width:150px; vertical-align:top;">
				<a href="product.jsp?id=2">
					<img src="res/card2.jpg" style="max-width:150px; max-height:150px; display: block; margin:auto;">
				</a>
			</td>
			<td style="vertical-align:top;">
				<a href="product.jsp?id=2"><b>Wald Plains</b></a>
				<br>
				<b>Quantity: </b> 1
				<br>
				A Plains printed with it's name as "Wald", German for forest.
			</td>
		</tr>
		
		<tr><td colspan=2><h2>Shipped Orders</h2></td></tr>
		<tr><td colspan=2><h3>Shipped On OrderedProduct.shipdate</h3></td></tr>
		<tr>
			<td style="width:150px; vertical-align:top;">
				<a href="product.jsp?id=2">
					<img src="res/card2.jpg" style="max-width:150px; max-height:150px; display: block; margin:auto;">
				</a>
			</td>
			<td style="vertical-align:top;">
				<a href="product.jsp?id=2"><b>Wald Plains</b></a>
				<br>
				<b>Quantity: </b> 2
				<br>
				A Plains printed with it's name as "Wald", German for forest.
			</td>
		</tr>
		
	</table>
	
</body>
</html>