<%@page import = "pageutils.*" %>
<%@page import = "dto.*" %>>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	out.println("<a href=\"home.jsp\">Go Home</a>");
	Cart cart = (Cart)session.getAttribute("cart");
	if(cart == null || cart.size() == 0){
		out.println("Your cart is empty");
	}else{
		out.println("<table style=\"width:100%; padding:10px;\">");
		for(CartItem item : cart){
			out.println("<tr>");
				out.println("<td>" + item.productid + "</td>");
				out.println("<td>" + item.name + "</td>");
				out.println("<td>" + item.price.toString() + "</td>");
				out.println("<td>" + item.quantity + "</td>");
			out.println("</tr>");
		}
		out.println("<table>");
		
	}
%>
</body>
</html>