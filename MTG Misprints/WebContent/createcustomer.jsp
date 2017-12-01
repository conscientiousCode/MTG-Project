<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="pageutils.*" %>
<%@ page import="dto.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Customer</title>
</head>
<body>
<%out.println(Header.getHeader((User)session.getAttribute("user"), (Cart)session.getAttribute("cart")));
	out.println(request.getParameter("province"));
	String email, password, verifypassword; 
	String firstName, lastName, address, city, province, postalCode;
	email = request.getParameter("email");
	password = request.getParameter("password");
	verifypassword = request.getParameter("verifypassword");
	if(password == null || verifypassword == null || !password.trim().equals(verifypassword.trim()) ){
		response.sendRedirect("customersignup.jsp?formentryerror=passwordmismatch");
		return;
	}else{
		firstName = request.getParameter("firstname");
		lastName = request.getParameter("lastname");
		address = request.getParameter("address");
		city = request.getParameter("city");
		province = request.getParameter("province");
		postalCode = request.getParameter("postalcode");
		Customer customer = Customer.getNewCustomer(email, password, firstName, lastName, address, city, province, postalCode);
		if(customer == null){
			response.sendRedirect("customersignup.jsp?formentryerror=customercreationfailed");
			return;
		}else{
			if(Customer.insertNewCustomer(customer)){
				response.sendRedirect("login.jsp?username="+customer.email+"&password="+customer.password);
			}else{
				response.sendRedirect("customersignup.jsp?formentryerror=customerinsertion");
			}
		}
	}
%>


</body>
</html>