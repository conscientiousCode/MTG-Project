<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="pageutils.*" %>
<%@ page import="dto.*" %>
<html>
<head>
	<title>MTG Misprints</title>
</head>
<body>

<%
	out.println(Header.getHeader((User)session.getAttribute("user"), (Cart)session.getAttribute("cart")));
%>	
	
	<!-- WEBPAGE CONTENT -->
	
	<h1>Sample Products</h1>
	
	<table>
				
		<% out.println("<table>");
		out.println(CardInfo.getCardInfo(Search.reverseOrder(Search.getSearchResults("", null))));
		out.println("<table>");%>
		
	</table>
	
</body>
</html>