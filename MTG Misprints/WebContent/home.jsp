<%@ page import="pageutils.*" %> 
<%@page import = "dto.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
        <title>MTG Misprints</title>
</head>
<body>
<%
		out.println(CommonHTML.getHeader(((User) session.getAttribute("user"))));

%>
</body>
</html>