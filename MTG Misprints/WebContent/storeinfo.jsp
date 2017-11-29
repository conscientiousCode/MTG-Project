<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="pageutils.*" %>
<html>
<head>
	<title>Store Info</title>
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
		
		<%
			try {
				Connection con = CommonSQL.getDBConnection();
				PreparedStatement ps = con.prepareStatement("SELECT cardproductid, image, name, price, inventory, description FROM CardProduct WHERE merchantid=10;");
				ps.execute();
				out.println(CardInfo.getCardInfo(ps.getResultSet(), CardInfo.NAME, CardInfo.PRICE, CardInfo.INV, CardInfo.DESC));
				con.close();
			} catch(SQLException e) {
				out.println(e.toString());
				e.printStackTrace();
			}
		%>
		
	</table>
	
	<h3><a href="addproduct.jsp">Add Product</a></h3>
	
	<table>
	
		<tr><td colspan=2><h2>Pending Orders</h2></td></tr>
		
		<tr><td colspan=2>
			<form method=get action=storeinfo.jsp>
				<h3>Ordered On: ProductOrder.orderdate <input type="submit" value="Mark As Shipped"></h3>
			</form>
		</td></tr>
		
		<%
			try {
				Connection con = CommonSQL.getDBConnection();
				PreparedStatement ps = con.prepareStatement("SELECT CardProduct.cardproductid, image, name, quantity, description FROM CardProduct JOIN InOrder ON CardProduct.cardproductid=InOrder.cardproductid WHERE merchantid=10;");
				ps.execute();
				out.println(CardInfo.getCardInfo(ps.getResultSet(), CardInfo.NAME, CardInfo.QUANT, CardInfo.DESC));
				con.close();
			} catch(SQLException e) {
				out.println(e);
				e.printStackTrace();
			}
		%>
		
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