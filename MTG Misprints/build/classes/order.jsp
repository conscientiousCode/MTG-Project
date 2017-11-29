<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order Processing</title>
</head>
<body>

<% 
String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;databaseName=db_dherman";
String user = "dherman";
String pw = "55848162";

// Get customer id
String custId = request.getParameter("customerId");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Determine if valid customer id was entered
// Determine if there are products in the shopping cart
// If either are not true, display an error message



// Save order information to database

try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}



String sql = "Select count(1) From Customer WHERE customerID = ?";
//Make connection
try(Connection con = DriverManager.getConnection(url, user, pw);
		PreparedStatement ps = con.prepareStatement(sql);){
	//Ensure that they have product to int their cart
	if(productList == null || productList.size() == 0){
		throw new IllegalStateException("");
	}
	//Ensure that they have a valid customer id (that is the customer has been registered with the database previously)
	if(custId != null){
		ps.setInt(1, Integer.parseInt(custId));
		ResultSet rs = ps.executeQuery();
		if(rs.next()){//If there is a Customer with the given Id
			
			
			//If we reach here, all conditions are met
			//Begin processing order
			BigDecimal total = BigDecimal.ZERO;
		
			//Create an order in Orders and retrieve the auto generated primary key
			PreparedStatement pstmt = con.prepareStatement("INSERT INTO Orders(customerId) VALUES (?)", Statement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1,Integer.parseInt(custId));
			pstmt.execute();
			ResultSet keys = pstmt.getGeneratedKeys();
			keys.next();
			int orderId = keys.getInt(1);
			
			//Preparing the insertion sql to link each product and their quantity to the order
			sql = "INSERT INTO OrderedProduct(orderId, productId, quantity, price) VALUES (?,?,?,?)";
			int productId, quantity; 
			BigDecimal price;
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, orderId);
			
			for(ArrayList<Object> item : productList.values()){
				//0:id, 1:name, 2:price, 3:quantity
				productId = Integer.parseInt((String)item.get(0));
				quantity = (Integer)item.get(3);
				price = new BigDecimal((String)item.get(2));
				
				total = total.add(price.multiply(new BigDecimal(quantity)));
				
				pstmt.setInt(2, productId);
				pstmt.setInt(3, quantity);
				pstmt.setBigDecimal(4, price);
				pstmt.execute();
				
			}
			
			pstmt = con.prepareStatement("UPDATE Orders SET totalAmount = ? WHERE orderId = ?");
			pstmt.setBigDecimal(1, total);
			pstmt.setInt(2, orderId);
			pstmt.execute();
			pstmt.close();
			
			out.println("THANK YOU, YOUR ORDER HAS BEEN PLACED");
		}else{
			out.println("No such customer exists in the database with id: " + custId );			
		}
	}
	
}catch(SQLException e){
	out.println("Failed to correctly contact the server.");
	System.out.println(e);
	//e.printStackTrace();
}catch(NumberFormatException e){
	out.println("Oops, the customer Id the server received seems to not be numeric!");
}catch(IllegalStateException e){
	out.println("You cannot checkout an empty cart.");
}finally{
	session.setAttribute("productList", null);
	out.println("<a href = listprod.jsp>Back to Products</a>");
}
	/*
	// Use retrieval of auto-generated keys.
	PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);			
	ResultSet keys = pstmt.getGeneratedKeys();
	keys.next();
	int orderId = keys.getInt(1);
	*/

// Insert each item into OrderedProduct table using OrderId from previous INSERT

// Update total amount for order record

// Here is the code to traverse through a HashMap
// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price

/*
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int qty = ( (Integer)product.get(3)).intValue();
            ...
	}
*/

// Print out order summary
%>
</BODY>
</HTML>

