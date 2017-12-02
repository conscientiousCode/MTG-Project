<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="pageutils.*" %>
<%@ page import="dto.*" %>
<%
	User user = (User) session.getAttribute("user");
	Cart cart = (Cart) session.getAttribute("cart");
	if(user == null || cart == null){
		response.sendRedirect("home.jsp");
		return;
	}

	try {
		Connection con = CommonSQL.getDBConnection();
		PreparedStatement ps1 = con.prepareStatement("INSERT INTO ProductOrder (custid, orderdate, creditcard, cardexpiry, totalcost) VALUES (?, ?, ?, ?, ?);", PreparedStatement.RETURN_GENERATED_KEYS);
		cart = NewOrderUtils.validateCartQuantities(cart);
		String creditcard = request.getParameter("creditcard");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date cardexpiry = new Date(format.parse(request.getParameter("cardexpiry")).getTime());
		ps1.setInt(1, user.suid);
		ps1.setDate(2, new Date(System.currentTimeMillis()));
		ps1.setString(3, creditcard);
		ps1.setDate(4, cardexpiry);
		ps1.setBigDecimal(5, cart.total);
		ps1.execute();
		ResultSet keys = ps1.getGeneratedKeys();
		if(keys.next()) {
			System.out.println("I am working");
			int orderid = keys.getInt(1);
			PreparedStatement ps3 = con.prepareStatement("INSERT INTO InOrder (cardproductid, productorderid, quantity) VALUES (?, ?, ?);");
			for(CartItem item : cart) {
				System.out.println(NewOrderUtils.removeQuantityFromCardProduct(item.productid, item.quantity));
				ps3.setInt(1, item.productid);
				ps3.setInt(2, orderid);
				ps3.setInt(3, item.quantity);
				ps3.execute();
			}

			ps3.close();
		}
		session.setAttribute("cart",new Cart(cart.getUser()));
		ps1.close();
		con.close();
		session.setAttribute("cart", new Cart(user));
	} catch(SQLException e) {
		e.printStackTrace();
	}
	response.sendRedirect("myorders.jsp");
%>