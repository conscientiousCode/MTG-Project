<%@ page import="pageutils.Test" %> 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
        <title>MTG Misprints</title>
</head>
<body>
	<table style="width:100%; padding:10px;">
		<tr>
			<td style="width:33%; text-align:left;">
				<image src="res/Logo.png">
			</td>
			<td style="width:33%; text-align:center;">
				<b>Search Cards</b><br>
				<form method=get action=searchresults.jsp>
					<input type="text" name="querry" size="20">
					<input type="submit" value="Search">
				</form>
			</td>
			<td style="width:33%; text-align:right;">
				<form method=get action=login.jsp>
					<input type="text" name="username" value="Username"><br>
					<input type="text" name="password" value="Password"><br>
					<input type="submit" value="Login">
				</form>
			</td>
		</tr>
	</table>
	<table>
		
	</table>
</body>
</html>