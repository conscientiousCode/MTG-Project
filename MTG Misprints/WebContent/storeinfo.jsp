<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="pageutils.*" %>
<%@ page import="dto.*" %>
<html>
<head>
	<title>Store Info</title>
</head>
<body>
	
	<!-- WEBPAGE HEADER -->
	<%out.println(Header.getHeader((User)session.getAttribute("user")));%>
	
	<!-- WEBPAGE CONTENT -->
	
	<h1>Store Info</h1>
	
	<h2>Settings</h2>
	
	<table>
		<tr>
			<td><b>Name:</b></td>
			<td>Merchant.name</td>
		</tr>
		<tr>
			<td><b>E-Mail:</b></td>
			<td>currentemail@somedomain.com</td>
		</tr>
	</table>
	<h3><a href="settings.jsp">Modify</a></h3>
	
	<h2>Products</h2>
	
	<h3><a href="addproduct.jsp">Add Product</a></h3>
	
	<table>
		
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
				<b>Inventory: </b> CardProduct.inventory
				<br>
				<b>Tags: </b>
				<a href="searchresults.jsp?tag=CardAttribute.name">CartAttribute.name</a>, 
				<a href="searchresults.jsp?tag=CardAttribute.name">CartAttribute.name</a>,
				<a href="searchresults.jsp?tag=CardAttribute.name">CartAttribute.name</a>
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
				<a href="product.jsp?id=1"><b>Wald Plains</b></a>
				<br>
				<b>Price: </b> $300.00
				<br>
				<b>Inventory: </b> 10
				<br>
				<b>Tags: </b>
				<a href="searchresults.jsp?tag=foreignlanguage">Foreign Language</a>, 
				<a href="searchresults.jsp?tag=misprint">Misprint</a>,
				<a href="searchresults.jsp?tag=land">Land</a>
				<br>
				A Plains printed with it's name as "Wald", German for forest.
			</td>
		</tr>
		
	</table>
	
	<h3><a href="addproduct.jsp">Add Product</a></h3>
	
	<h2>Pending Orders</h2>
	
	<table>
		
		<tr><td colspan=2>
			<form method=get action=storeinfo.jsp>
				<h3>Ordered On: ProductOrder.orderdate <input type="submit" value="Mark As Shipped"></h3>
			</form>
		</td></tr>
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
		
		<tr><td colspan=2>
			<form method=get action=storeinfo.jsp>
				<h3>Ordered On: 11/30/17 <input type="submit" value="Mark As Shipped"></h3>
			</form>
		</td></tr>
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
		<tr><td colspan=2><h3>Shipped On: OrderedProduct.shipdate</h3></td></tr>
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