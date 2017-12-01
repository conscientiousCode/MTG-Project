<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="pageutils.*" %>
<%@ page import="dto.*" %>
<html>
<head>
	<title>Advanced Search</title>
</head>
<body>
	
<%
	out.println(Header.getHeader((User)session.getAttribute("user")));
%>
	
	<!-- WEBPAGE CONTENT -->
	
	<h1>Advanced Search</h1>
	
	<form method=get action=searchresults.jsp>
	
		<b>Product Name</b><br>
		<input type="text" name="querry" size=30><br>
		<br>
		
		<b>Cart Attributes</b><br>
		<%
			try(Connection con = CommonSQL.getDBConnection();
					PreparedStatement pstmt = con.prepareStatement("Select name FROM CardAttribute");){
				 ResultSet rs = pstmt.executeQuery();
				 while(rs.next()){
					 System.out.println("running");
					 String name = rs.getString("name");
					 out.println("<input type=\"checkbox\" name=\""+ name+ "\">"+ name + "<br>");
				 }
			}catch(ClassNotFoundException e){
				
			}catch(SQLException e){
				
			}
		%>
		
		<br>
		
		<input type="submit" value="Advanced Search">
		
		
	</form>
	
</body>
</html>