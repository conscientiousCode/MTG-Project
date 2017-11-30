<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="pageutils.*" %>
<%@ page import="dto.*" %>
<html>
<head>
	<title>MTG Misprints</title>
</head>
<body>
	<table style="margin:1em auto;">
		<tr>
			<td style="width:100%; text-align:center;">
				<b>Please Login to Access the Requested Feature</b>
			</td>
		</tr>
		<tr>
			<td style="width:100%; text-align:center;">
			<% String returnPage = request.getParameter("returnpage");
				if(returnPage != null){
					out.println("<form method=post action=login.jsp?returnpage="+ returnPage + ">");
				}else{
					out.println("<form method=post action=login.jsp>");
				}
			%>
					<input type="text" name="username" placeholder="Username" required><br>
					<input type="password" name="password" placeholder="Password" required><br>
					<input type="submit" value="Login">
				</form>
			</td>
		</tr>
	</table>
<%
	
%>	

</body>
</html>