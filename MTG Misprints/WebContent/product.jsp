<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="pageutils.*" %>
<%@ page import="dto.*" %>

<%
	int id = Integer.parseInt(request.getParameter("id"));
	String name = "";
	try {
		Connection con = CommonSQL.getDBConnection();
		PreparedStatement ps = con.prepareStatement("SELECT name FROM CardProduct WHERE cardproductid=?");
		ps.setInt(1, id);
		ps.execute();
		ResultSet rs = ps.getResultSet();
		if(rs.next()) {
			name = rs.getString(1);
		}
	} catch(SQLException e) {
		e.printStackTrace();
	}
%>

<html>
<head>
	<title><% out.println(name); %></title>
</head>
<body>
	
	<!-- WEBPAGE HEADER -->
	<%out.println(Header.getHeader((User)session.getAttribute("user")));%>
	
	<!-- WEBPAGE CONTENT -->
	
	<h1>CardProduct.cardname</h1>
	
	<table>
		
		<tr>
			<td style="width:150px; vertical-align:top;">
				<a href="product.jsp?id=1">
					<img src="res/card1.jpg" style="max-width:150px; max-height:150px; display: block; margin:auto;">
				</a>
			</td>
			
			<%
			%>
			
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