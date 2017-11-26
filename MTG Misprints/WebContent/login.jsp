<%@page import = "pageutils.*" %>
<%@page import = "dto.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body>
<%
	User user = UserAuthentification.authenticate(request.getParameter("username"), request.getParameter("password"));
	if(user == null){
		out.println("SQL_ERROR(login) cause authentification to fail. Contact administator");
	}else if(user.userGroup == User.GROUP_CUSTOMER){
		session.setAttribute("user", user);
		response.sendRedirect("home.jsp");
	}else if(user.userGroup == User.GROUP_MERCHANT){
		session.setAttribute("user", user);
		response.sendRedirect("home.jsp");
	}else if(user.userGroup == User.GROUP_FAILED_LOGIN){
		
	}else{
		out.println("Unexpected case reached, please contact a site administator");
	}
%>
</body>
</html>