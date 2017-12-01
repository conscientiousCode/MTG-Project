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
					 String name = rs.getString("name");
					 out.println("<input type=\"checkbox\" name=\""+ attribute1+">"+ +"<br>");
				 }
			}
		%>
		
		<input type="checkbox" name="attribute1">attribute1<br>
		<input type="checkbox" name="attribute2">attribute2<br>
		<input type="checkbox" name="attribute3">attribute3<br>
		<input type="checkbox" name="misprint">Misprint<br>
		<input type="checkbox" name="foreignlanguage">Foreign Language<br>
		<br>
		
		<input type="submit" value="Advanced Search">
		
		
	</form>
	
</body>
</html>