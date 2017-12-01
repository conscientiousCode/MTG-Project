<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="pageutils.*" %>
<%@ page import="dto.*" %>
<%
	Cart cart = (Cart) session.getAttribute("cart");
	int id = Integer.parseInt(request.getParameter("id"));
	cart.addItemToCart(Cart.getCartItemFor(id, 1));
	response.sendRedirect("cart.jsp");
%>