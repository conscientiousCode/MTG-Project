<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Daniel's Dumpster Dines Grocery Order List</title>
</head>
<body>

<h1>Daniel's Dumpster Dines Grocery Orders</h1>

<%
	//Note: Forces loading of SQL Server driver

String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;databaseName=db_dherman";
String user = "dherman";
String pw = "55848162";

try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00


String sql = "SELECT orderId, Customer.customerId, cname, totalAmount"
				+ " FROM Customer, Orders"
				+ " WHERE Customer.customerId = Orders.customerId"
				+ " ORDER BY orderId";

String pSql = "SELECT DISTINCT productId, quantity, price, OrderedProduct.orderId"
			+ " FROM OrderedProduct, Orders"
			+ " WHERE OrderedProduct.orderId = ?";
// Make connection
try(Connection con = DriverManager.getConnection(url, user, pw);
		PreparedStatement ps = con.prepareStatement(sql);
		PreparedStatement pps = con.prepareStatement(pSql);){

	String o = "<td>", c = "</td>";
	StringBuilder output = new StringBuilder("<table border=\"1\"><tr><th>Order Id</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");
	
	ResultSet rs = ps.executeQuery();
	ResultSet prs;
	
	NumberFormat currency = NumberFormat.getCurrencyInstance();
	
	while(rs.next()){
		output.append("<tr>");
		output.append(o + rs.getString("orderId") + c + o + rs.getString("customerId") + c + o + rs.getString("cname") + c
			+ o + currency.format(rs.getBigDecimal("totalAmount")) + c);
		output.append("</tr>");
		
		pps.setInt(1, rs.getInt("orderId"));
		prs = pps.executeQuery();
		
		output.append("<tr align=\"right\"><td colspan=\"4\"><table border=\"1\">"
				+ "<th>Product Id</th> <th>Quantity</th> <th>Price</th></tr>");
		
		while(prs.next()){
			output.append("<tr>");
			output.append(o + prs.getString("productId") + c + o + prs.getString("quantity") + c + o + currency.format(prs.getBigDecimal("price")) + c );
			output.append("</tr>");
		}
		
		output.append("</table></td></tr>");
		
		/*output.append("<tr align=\"right\"><td colspan=\"4\"><table border=\"1\">"
				+ "<th>Product Id</th> <th>Quantity</th> <th>Price</th></tr>");
		output.append("</table></td></tr>");*/
	}
	
	
	out.println(output.toString());
}catch(SQLException e){
	System.out.println(e);
}

%>

</body>
</html>

