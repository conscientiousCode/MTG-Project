package pageutils;
import dto.User;

public class CommonHTML {

	/**
	 * This method is intended to handle all possible branches (not logged in OR logged in as user or merchant)
	 * 
	 * @param userId
	 * @return
	 */
	public static String getHeader(User user){
		if(user == null){
			return getHeaderForNotLoggedIn();
		}else if(user.userGroup == User.GROUP_CUSTOMER){//Currently do the same thing
			return getHeaderForCustomer(user);
		}else{
			return "unimplemented user type in CommonHTML:getHeader";
		}
	}
	
	private static String getHeaderForNotLoggedIn(){
		return "<table style=\"width:100%; padding:10px;\">"
				+ "<tr>"
					+ "<td style=\"width:33%; text-align:left;\">"
						+ "<image src=\"res/Logo.png\">"
					+ "</td>"
					+ "<td style=\"width:33%; text-align:center;\">"
						+ "<b>Search Cards</b><br>"
						+ "<form method=get action=searchresults.jsp>"
							+ "<input type=\"text\" name=\"querry\" size=\"20\">"
							+ "<input type=\"submit\" value=\"Search\">"
						+ "</form>"
					+ "</td>"
					+ "<td style=\"width:33%; text-align:right;\">"
						+ "<form method=get action=login.jsp>"
							+ "<input type=\"text\" name=\"username\" value=\"Username\"><br>"
							+ "<input type=\"text\" name=\"password\" value=\"Password\"><br>"
							+ "<input type=\"submit\" value=\"Login\">"
						+ "</form>"
					+ "</td>"
				+ "</tr>"
			+ "</table>"
			+ "<table>"	
			+ "</table>";
	}
	
	private static String getHeaderForCustomer(User user){
		return "<table style=\"width:100%; padding:10px;\">"
				+ "<tr>"
					+ "<td style=\"width:33%; text-align:left;\">"
						+ "<image src=\"res/Logo.png\">"
					+ "</td>"
					+ "<td style=\"width:33%; text-align:center;\">"
						+ "<b>Search Cards</b><br>"
						+ "<form method=get action=searchresults.jsp>"
							+ "<input type=\"text\" name=\"querry\" size=\"20\">"
							+ "<input type=\"submit\" value=\"Search\">"
						+ "</form>"
					+ "</td>"
					+ "<td style=\"width:33%; text-align:right;\">"
						+ "WELCOME " + user.name
					+ "</td>"
					+ "<td style=\"width:33%; text-align:right;\">"
						+ "<a href=\"cart.jsp\">My Cart</a>" 
					+ "</td>"
					+ "<td style=\"width:33%; text-align:right;\">"
						+ "<a href=\"logout.jsp\">Logout</a>" 
					+ "</td>"
				+ "</tr>"
			+ "</table>"
			+ "<table>"	
			+ "</table>";
	}
}
