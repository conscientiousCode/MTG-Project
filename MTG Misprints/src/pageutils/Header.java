package pageutils;
import dto.User;

public class Header {
	
	public static String getHeader(User user, Cart cart){
		
		if(user == null){
			return getDefaultHeader();
		}
		StringBuilder header = new StringBuilder();
		openTableAndRow(header);
		getLogo(header);
		getSearchBar(header);
		

		switch(user.userGroup){
		case User.GROUP_CUSTOMER:
			getCustomerLoginData(user, cart, header);
			break;
		case User.GROUP_MERCHANT:
			getMerchantLoginData(user, header);
			break;
		case User.GROUP_FAILED_LOGIN:
			return "Oops, Credentials failed to match an account, please try again + <a href=\"home.jsp\">Home</a>";
			//break;
		case User.GROUP_ERROR:
			throw new IllegalStateException("If this has been hit, then something throws a User.Group_Error Now");
		default:
			getLoginInfo(header);
		}
		
		closeRowAndTable(header);
		return header.toString();
	}

	public static void getLogo(StringBuilder header){
		header.append("<td style=\"width:33%; text-align:left;\">"
				+ "	<a href=\"home.jsp\"><img src=\"res/Logo.png\"></a>"
				+ "	</td>");
	}
	
	public static void getSearchBar(StringBuilder header){
		header.append("<td style=\"width:33%; text-align:center;\">"
				+ "				<b>Search Cards</b>"
				+ "				<br>"
				+ "				<form method=get action=searchresults.jsp>"
				+ "					<input type=\"text\" name=\"querry\" size=\"20\">"
				+ "					<input type=\"submit\" value=\"Search\">"
				+ "				</form>"
				+ "				<a href=\"advancedsearch.jsp\">Advanced Search</a>"
				+ "			</td>");
	}
	
	public static void getLoginInfo(StringBuilder header){
		header.append("<td style=\"width:33%; text-align:right;\">"
				+ "				<form method=post action=login.jsp>"
				+ "					<input type=\"text\" name=\"username\" placeholder=\"Username\" required><br>"
				+ "					<input type=\"password\" name=\"password\" placeholder=\"Password\" required><br>"
				+ "					<input type=\"submit\" value=\"Login\">"
				+ "				</form>"
				+ "			</td>");
	}
	
	public static void getCustomerLoginData(User user, Cart cart, StringBuilder header){
		header.append("<td style=\"width:33%; text-align:right;\">"
				+ "				<a href=\"myorders.jsp\"><b>"+ user.name +"</b></a><br><br>"
				+ "				<a href=\"cart.jsp\"><b>My Cart</b></a> - Total: $" + cart.total + "<br>"
				+ "              <table style=\"width:100%; text-align:right;\"><tr><td>"
				/*+ "				<form method=get action=myorders.jsp>"
				+ "					<input type=\"submit\" value=\"Order History\">"
				+ "				</form>"*/
				+ "				<form method=get action=logout.jsp>"
				+ "					<input type=\"submit\" value=\"Logout\">"
				+ "				</form>"
				+ "             </td></tr></table>");
	}
	
	public static void getMerchantLoginData(User user, StringBuilder header){
		header.append("<td style=\"width:33%; text-align:right;\">"
				+ "				<a href=\"storeinfo.jsp\"><b>"+ user.name +"</b></a><br>"
				+ "				<form method=get action=logout.jsp>"
				+ "					<input type=\"submit\" value=\"Logout\">"
				+ "				</form>");
	}
	
	public static void openTableAndRow(StringBuilder header){
		header.append("<table style=\"width:100%; padding:10px;\">"
				+ "		<tr>");
	}
	public static void closeRowAndTable(StringBuilder header){
		header.append("</tr></table>");
	}
	
	public static String getDefaultHeader(){
		StringBuilder header = new StringBuilder();
		openTableAndRow(header);
		getLogo(header);
		getSearchBar(header);
		getLoginInfo(header);
		closeRowAndTable(header);
		return header.toString();
	}
	
}
