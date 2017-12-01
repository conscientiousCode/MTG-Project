<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="pageutils.*" %>
<%@ page import="dto.*" %>
<html>
<head>
	<title>Settings</title>
</head>
<body>
	
<%
	out.println(Header.getHeader((User)session.getAttribute("user"), (Cart)session.getAttribute("cart")));
%>	
	
	<!-- WEBPAGE CONTENT -->
	<!-- TODO: seperate pages for merchants and customers -->
	
	<h1>Settings</h1>
	
	<h2>E-Mail</h2>
	
	<%
		String email = "";
		String firstName = "";
		String lastName = "";
		String address = "";
		String city = "";
		String province = "";
		String postalCode = "";
		try(Connection con = CommonSQL.getDBConnection();
			PreparedStatement pstmt = con.prepareStatement("SELECT SiteUser.*, Customer.* FROM SiteUser, Customer WHERE custid = ?")){
			User user = (User)session.getAttribute("user");
			if(user == null){
				response.sendRedirect("home.jsp");
				return;
			}
			pstmt.setInt(1, user.suid);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()){
				email = rs.getString("email");
				firstName = rs.getString("firstname");
				lastName = rs.getString("lastname");
				address = rs.getString("address");
				city = rs.getString("city");
				province = rs.getString("province");
				postalCode = rs.getString("postalcode");
			}else{
				out.println("Failed to connect to the database, please try your request again.");
			}
	} %>
	<form method=post action=settings.jsp>
		<table>
			<tr>
				<td><b>Current E-Mail:</b></td>
				<td><%out.println(email);%></td>
			</tr>
			<tr>
				<td><b>New E-Mail:</b></td>
				<td><input type="text" name="email1"></td>
			</tr>
			<tr>
				<td><b>Confirm New E-Mail:</b></td>
				<td><input type="text" name="email2"></td>
			</tr>
		</table>
		<input type="submit" value="Update">
	</form>
	
	<h2>Shipping Information</h2>
	
	<form method=post action=settings.jsp>
		<table>
			<tr>
				<td><b>First Name:</b></td>
				<td><input type="text" name="firstname" value="<%out.print(firstName);%>"></td>
			</tr>
			<tr>
				<td><b>Last Name:</b></td>
				<td><input type="text" name="lastname" value="<%out.print(lastName);%>"></td>
			</tr>
			<tr>
				<td><b>Address:</b></td>
				<td><input type="text" name="address" value="<%out.print(address);%>"></td>
			</tr>
			<tr>
				<td><b>City:</b></td>
				<td><input type="text" name="city" value="<%out.print(city);%>"></td>
			</tr>
			<tr>
				<td><b>Province:</b></td>
				<td>
					<select name="province" value="<%out.print(province);%>">
						
					<% 
						for(String prov: Customer.PROVINCES){
							out.println("<option value=\""+ prov+ "\">" + prov+ "</option>");
						}
					%>
					</select>
				</td>
			</tr>
			<tr>
				<td><b>Postal Code:</b></td>
				<td><input type="text" name="postalcode" value="<%out.print(postalCode);%>"></td>
			</tr>
		</table>
		<input type="submit" value="Update">
	</form>
	
	<h2>Password</h2>
	
	<form method=post action=settings.jsp>
		<table>
			<tr>
				<td><b>New Password:</b></td>
				<td><input type="password" name="newpassword1"></td>
			</tr>
			<tr>
				<td><b>Confirm New Password:</b></td>
				<td><input type="password" name="newpassword2"></td>
			</tr>
		</table>
		<input type="submit" value="Update">
	</form>
	
</body>
</html>