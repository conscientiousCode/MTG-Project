<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<html>
<head>
	<title>Settings</title>
</head>
<body>
	
	<!-- WEBPAGE HEADER -->
	<!-- TODO: java for login/logout -->
	
	<table style="width:100%; padding:10px;">
		<tr>
			
			<!-- Logo -->
			<td style="width:33%; text-align:left;">
				<a href="home.jsp"><img src="res/Logo.png"></a>
			</td>
			
			<!-- Search Bar -->
			<td style="width:33%; text-align:center;">
				<b>Search Cards</b>
				<br>
				<form method=get action=searchresults.jsp>
					<input type="text" name="querry" size="20">
					<input type="submit" value="Search">
				</form>
				<a href="advancedsearch.jsp">Advanced Search</a>
			</td>
			
			<!-- Either login or logout widget -->
			
			<!-- Login -->
			<!--
			<td style="width:33%; text-align:right;">
				<form method=post action=login.jsp>
					<input type="text" name="username" placeholder="Username" required><br>
					<input type="password" name="password" placeholder="Password" required><br>
					<input type="submit" value="Login">
				</form>
			</td>
			-->
			
			<!-- Logout -->
			<td style="width:33%; text-align:right;">
				<a href="settings.jsp"><b>Jeff Thomson</b></a><br><br>
				<form method=get action=logout.jsp>
					<input type="submit" value="Logout">
				</form>
			</td>
			
		</tr>
	</table>
	
	<!-- WEBPAGE CONTENT -->
	<!-- TODO: seperate pages for merchants and customers -->
	
	<h1>Settings</h1>
	
	<h2>E-Mail</h2>
	
	<form method=post action=settings.jsp>
		<table>
			<tr>
				<td><b>Current E-Mail:</b></td>
				<td>currentemail@somedomain.com</td>
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
				<td><input type="text" name="firstname" value="Jeff"></td>
			</tr>
			<tr>
				<td><b>Last Name:</b></td>
				<td><input type="text" name="lastname" value="Thomson"></td>
			</tr>
			<tr>
				<td><b>Address:</b></td>
				<td><input type="text" name="address" value="1 Alumni Ave."></td>
			</tr>
			<tr>
				<td><b>City:</b></td>
				<td><input type="text" name="city" value="Kelowna"></td>
			</tr>
			<tr>
				<td><b>Province:</b></td>
				<td>
					<select name="province">
						<option value="AB">AB</option>
						<option value="BC">BC</option>
						<option value="MB">MB</option>
						<option value="NB">NB</option>
						<option value="NL">NL</option>
						<option value="NS">NS</option>
						<option value="NT">NT</option>
						<option value="NU">NU</option>
						<option value="ON">ON</option>
						<option value="PE">PE</option>
						<option value="WC">QC</option>
						<option value="SK">SK</option>
						<option value="YT">YT</option>
					</select>
				</td>
			</tr>
			<tr>
				<td><b>Postal Code:</b></td>
				<td><input type="text" name="postalcode" value="A1A1A1"></td>
			</tr>
		</table>
		<input type="submit" value="Update">
	</form>
	
	<h2>Password</h2>
	
	<form method=post action=settings.jsp>
		<table>
			<tr>
				<td><b>Old Password:</b></td>
				<td><input type="text" name="password"></td>
			</tr>
			<tr>
				<td><b>New Password:</b></td>
				<td><input type="text" name="newpassword1"></td>
			</tr>
			<tr>
				<td><b>Confirm New Password:</b></td>
				<td><input type="text" name="newpassword2"></td>
			</tr>
		</table>
		<input type="submit" value="Update">
	</form>
	
</body>
</html>