<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<html>
<head>
	<title>Add Product</title>
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
				<a href="storeinfo.jsp"><b>Merchant.name</b></a><br><br>
				<form method=get action=logout.jsp>
					<input type="submit" value="Logout">
				</form>
			</td>
			
		</tr>
	</table>
	
	<!-- WEBPAGE CONTENT -->
	
	<h1>Add Product</h1>
	
	<form method=post action=storeinfo.jsp>
		<table>
			<tr>
				<td><b>Name:</b></td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td><b>Price:</b></td>
				<td><input type="text" name="price"></td>
			</tr>
			<tr>
				<td><b>Inventory:</b></td>
				<td><input type="number" name="inventory"></td>
			</tr>
			<tr>
				<td style="vertical-align:top"><b>Description:</b></td>
				<td><textarea rows=10 cols=50 name="description"></textarea></td>
			</tr>
			<tr>
				<td style="vertical-align:top"><b>Upload Image:</b></td>
				<td><input type="file" name="image"></td>
			</tr>
		</table>
		<input type="submit" value="Submit">
	</form>
	
</body>
</html>