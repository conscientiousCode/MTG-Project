<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="pageutils.*" %>
<%@ page import="dto.*" %>
<html>
<head>
	<title>Place Order</title>
</head>
<body>
	<form method=post action="completeorder.jsp">
		<b>Credit Card: </b><input type=text name="creditcard" maxlength=16 required><br>
		<b>Expiry: </b><input type=date name="cardexpiry" required><br>
		<input type=submit value="Submit">
	</form>
</body>
</html>