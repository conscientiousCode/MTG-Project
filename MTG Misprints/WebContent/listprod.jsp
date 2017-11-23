<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.math.BigDecimal" %>>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery</title>
</head>
<body>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for

String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;databaseName=db_dherman";
String user = "dherman";
String pw = "55848162";

String name = request.getParameter("productName");
		
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!


String sql = "Select productId, productName, price FROM Product WHERE LOWER(productName) LIKE ? ORDER BY productName ASC";

try(
		Connection con = DriverManager.getConnection(url, user, pw);
		Statement stmt = con.createStatement();
){
	PreparedStatement ps;
	response.setCharacterEncoding("UTF-8");
	
	//stmt.executeQuery("SET NAMES 'UTF8'");
	if(name != null && !name.equals("")){
		name = name.toLowerCase();
		//System.out.println(name);
		ps = con.prepareStatement("Select productId, productName, price FROM Product WHERE LOWER(productName) LIKE ? ORDER BY productName ASC");
		ps.setString(1, ("%"+name+"%"));
	}else{
		ps = con.prepareStatement("Select productId, productName, price FROM Product ORDER BY productName ASC");
	}
	
	StringBuilder output = new StringBuilder("<table><tr><th>Add to Cart</th><th>Product Name</th><th>Price</th></tr>");
	NumberFormat fmt = NumberFormat.getCurrencyInstance();
	
	ResultSet rs = ps.executeQuery();
	
	String o = "<td>", c = "</td>";
	int id;
	String pName;
	BigDecimal price;
	while(rs.next()){
		id = rs.getInt("productId");
		pName = rs.getString("productName");
		price = rs.getBigDecimal("price");
		output.append("<tr>");
		output.append(o + "<a href=\"addcart.jsp?id="+id +"&name="+pName.replace(" ","+")+"&price="+price +"\">Add</a>" + c);
		output.append(o + pName + c + o + fmt.format(price) + c);
		output.append("</tr>");
	}
	
	out.println(output);
	ps.close();
}

// Make the connection

// Print out the ResultSet

// For each product create a link of the form
// addcart.jsp?id=<productId>&name=<productName>&price=<productPrice>

// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>

</body>
</html>