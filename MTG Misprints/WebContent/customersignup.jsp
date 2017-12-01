<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="pageutils.*" %>
<%@ page import="dto.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%out.println(Header.getHeader((User)session.getAttribute("user"), (Cart)session.getAttribute("cart")));%>
	<%
		String error = request.getParameter("formentryerror");
		if(error != null){
			out.println(error);
		}
		
	%>
	<h2><b>Create User Form: </b></h2><br>
	<form method=get action=createcustomer.jsp>
		<table>
		<tr><td><b>email:</b></td><td><input type="text" name="email" size=50></td></tr>
		<tr><td><b>password:</b></td><td><input type="password" name="password" size=30></td></tr>
		<tr><td><b>verify password:</b></td><td><input type="password" name="verifypassword" size=30></td></tr>
		<tr><td><b>first name:</b></td><td><input type="text" name="firstname" size=20></td></tr>
		<tr><td><b>last name:</b></td><td><input type="text" name="lastname" size=30></td></tr>
		<tr><td><b>street address:</b></td><td><input type="text" name="address" size=50></td></tr>
		<tr><td><b>city:</b></td><td><input type="text" name="city" size=25></td></tr>
		<tr><td><b>province:</b></td><td><select name="province">
		<% 
			for(String prov: Customer.PROVINCES){
				out.println("<option value=\""+ prov+ "\">" + prov+ "</option>");
			}
		%>
		</select></td></tr>
		<tr><td><b>postal code (nospace):</b></td><td><input type="text" name="postalcode" size=6></td></tr>
		</table>
		<input type="submit" value="submit">
	</form>

</body>
</html>