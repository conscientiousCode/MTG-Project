<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="pageutils.*" %>
<%@ page import="dto.*" %>
<html>
<head>
	<title>Checkout</title>
</head>
<body>

<%
	User user = ((User)session.getAttribute("user"));

	if(user == null){
		response.sendRedirect("RequestLogin.jsp?returnpage=checkout.jsp");
	}else{
		out.println(Header.getHeader(user, (Cart)session.getAttribute("cart")));
	}
	
	Cart userCart = (Cart)session.getAttribute("cart");
	if(userCart == null){
		out.println("You do not appear to have a cart, please logout and login again to try and fix the problem.");
		return;
	}
	
	Cart validatedCart = NewOrderUtils.validateCartQuantities((Cart)session.getAttribute("cart"));
	
	out.println("<b>Check your cart for items and Quantities: they may have changed to reflect item availability</b>");
	//Display validated cart
	
	//Forms for filling in payment information
	
	//submit forums and go on to validate their payment information
	
%>	

</body>
</html>