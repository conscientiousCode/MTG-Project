<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="pageutils.*" %>
<%@ page import="dto.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Recover Password</title>
</head>
<body>
<%
	out.println(Header.getHeader((User)session.getAttribute("user"), (Cart)session.getAttribute("cart")));
	out.println("<h2>Please Input Your Email To Recover Your Password</h2>");
%>	
	<form method=get action="sendpasswordrecoveryemail.jsp">
		<b>email: </b><input type="text" name="email" size=30>
		<input type="submit" value="recover">
	</form>

</body>
</html>