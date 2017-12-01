<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="pageutils.*" %>
<%@ page import="dto.*" %>
<%@ page import="java.math.BigDecimal" %>
<%
	
	int merchantid = ((User) session.getAttribute("user")).suid;
	String name = (String) request.getParameter("name");
	BigDecimal price = new BigDecimal((String) request.getParameter("price"));
	int inventory = Integer.parseInt(request.getParameter("inventory"));
	String description = (String) request.getParameter("description");
	
	try {
		Connection con = CommonSQL.getDBConnection();
		PreparedStatement ps = con.prepareStatement("INSERT INTO CardProduct (merchantid, name, price, inventory, description) VALUES (?, ?, ?, ?, ?);");
		ps.setInt(1, merchantid);
		ps.setString(2, name);
		ps.setBigDecimal(3, price);
		ps.setInt(4, inventory);
		ps.setString(5, description);
		ps.execute();
	} catch(SQLException e) {
		e.printStackTrace();
	}
	
	//TODO: image
	
	response.sendRedirect("./uploadServlet");
	
	//response.sendRedirect("storeinfo.jsp");

%>