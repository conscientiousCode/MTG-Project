<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="pageutils.*" %>
<%@ page import="dto.*" %>
<%@ page import="java.math.BigDecimal" %>
<html>
<head>
	<title>My Cart</title>
</head>
<body>
<%

	out.println(Header.getHeader((User)session.getAttribute("user"), (Cart)session.getAttribute("cart")));	

	Cart cart = (Cart) session.getAttribute("cart");
	if(cart == null || cart.size() == 0) {
		out.println("<h2>Your cart is empty</h2></body></html>");
		return;
	}
	
%>

	<form method=post action=placeorder.jsp>
		<input type="submit" value="Complete Order">
	</form>
	
	<%
		try {
			Connection con = CommonSQL.getDBConnection();
			PreparedStatement ps = con.prepareStatement("SELECT inventory FROM CardProduct WHERE cardproductid=?");
			out.println("<table>");
			for(CartItem item : cart) {
				out.println("<tr><td style=\"width:150px; vertival-align:top;\">");
				out.print("<a href=\"product.jsp?id=");
				out.print(item.productid);
				out.println("\">");
				out.print("<img src=");
				out.print(CommonSQL.getImageSourceForProduct(item.productid));
				out.println(" style=\"max-width:150px; max-height:150px; display: block; margin:auto;\"></a></td>");
				out.println("<td style=\"vertical-align:top\">");
				out.print("<a href=\"product.jsp?id=");
				out.print(item.productid);
				out.print("\"><b>");
				out.print(item.name);
				out.println("</b></a><br>");
				out.print("<b>Total Price: </b>$");
				out.print(item.price.multiply(new BigDecimal(item.quantity)));
				out.println("<br>");
				out.println("<form method=post action=cart.jsp>");
				out.println("<b>Quantity</b>");
				out.println("<select name=\"quantity\">");
				ps.setInt(1, item.productid);
				ps.execute();
				ResultSet rs = ps.getResultSet();
				if(rs.next()) {
					int max = rs.getInt(1);
					for(int i = 1; i <= max; i++) {
						out.print("<option value=");
						out.print(i);
						out.print(">");
						out.print(i);
						out.println("</option>");
					}
				}
				out.println("</select></form><br>");
				out.println(item.description);
				out.println("</td></tr>");
			}
			out.println("</table>");
			con.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	%>
	
	<form method=post action=placeorder.jsp>
		<input type="submit" value="Complete Order">
	</form>

</body>
</html>