<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="pageutils.*" %>
<%@ page import="dto.*" %>
<%@ page import="javax.mail.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SendRecovery</title>
</head>
<body>
<%
	out.println(pageutils.Header.getHeader((User)session.getAttribute("user"), (Cart)session.getAttribute("cart")));

	out.println("<h1>Please Input Your Email To Recover Your Password</h1>");
	if(Email.sendPasswordRecoveryEmail(request.getParameter("email"))){
		out.println("<h2>A recovery email has been sent: please check your email.</h2>");
	}else{
		out.println("<h2>Failed to send recovery message. Please check your email and try again</h2>");
	}
%>	

</body>
</html>