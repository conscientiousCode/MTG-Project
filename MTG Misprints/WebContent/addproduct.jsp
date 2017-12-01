<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="pageutils.*" %>
<%@ page import="dto.*" %>
<html>
<head>
	<title>Add Product</title>
</head>
<body>
	
<%
	User user = (User)session.getAttribute("user");
	if(user == null || user.userGroup != User.GROUP_MERCHANT){
		//TODO: redirecto to a page stating they cannot access that portion of the site
		out.println("If you are seeing this, there is unimplemented functionality");
	}
	out.println(Header.getHeader(user));
%>
	
	<!-- WEBPAGE CONTENT -->
	
	<h1>Add Product</h1>
	

	<form method=post action=uploadServlet enctype="multipart/form-data">
		<table>
			<tr>
				<td><b>Name:</b></td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td><b>Price ($):</b></td>
				<td><input type="number" min=0 step=0.01 name="price"></td>
			</tr>
			<tr>
				<td><b>Inventory:</b></td>
				<td><input type="number" min=1 name="inventory"></td>
			</tr>
			<tr>
				<td style="vertical-align:top"><b>Description:</b></td>
				<td><textarea rows=10 cols=50 name="description"></textarea></td>
			</tr>
			<tr>
				<td style="vertical-align:top"><b>Upload Image:</b></td>
				<td><input type="file" name="image" accept=".jpg"></td>
			</tr>
		</table>
		<input type="hidden" name="merchantid" value=<%out.print("\""+user.suid+"\"");%>>
		<input type="submit" value="Submit">
	</form>
	
</body>
</html>