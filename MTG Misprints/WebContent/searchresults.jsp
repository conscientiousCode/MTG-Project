<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="pageutils.*" %>
<%@ page import="dto.*" %>
<html>
<head>
	<title>Search Results</title>
</head>
<body>
	
	<!-- WEBPAGE HEADER -->
	<!-- TODO: java for login/logout -->
	
<%
	out.println(Header.getHeader((User)session.getAttribute("user"), (Cart)session.getAttribute("cart")));
%>
	
	
	<!-- WEBPAGE CONTENT -->
	<!-- TODO: fetch sample products via sql -->
	
	<h1>Search Results</h1>
	
	<%
		int[] attributes = ParseSearchRequest.getAttributes(request);
		String querry = request.getParameter("querry");
	
		out.println("<table>");
		out.println(CardInfo.getCardInfo(Search.getSearchResults(querry, attributes)));
		out.println("<table>");
	%>
	
</body>
</html>