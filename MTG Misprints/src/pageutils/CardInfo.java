package pageutils;

import java.sql.ResultSet;
import java.sql.SQLException;

public class CardInfo {
	
	public static final int NAME = 0;
	public static final int IMAGE = 1;
	public static final int PRICE = 2;
	public static final int DESC = 3;
	public static final int QUANT = 4;
	public static final int INV = 5;
	public static final int MERCH = 6;
	public static final int ATTR = 7;
	
	// Precondition: rs has CardProduct.id at 1, CardProduct.image at 2, ids at 3+
	public static String getCardInfo(ResultSet rs, int... ids) throws SQLException {
		
		StringBuilder result = new StringBuilder();
		
		while(rs.next()) {
			
			result.append("<tr>");
			result.append("<td style=\"width:150px; vertical-align:top;\">");
			result.append("<a href=\"product.jsp?id=");
			result.append(rs.getInt(1));
			result.append("\">");
			result.append("<img src=\"res/");
			// TODO: images via sql
			result.append("cardnoimage.png");
			result.append("\" style=\"max-width:150px; max-height:150px; display: block; margin:auto;\">");
			result.append("</a>");
			result.append("</td>");
			
			result.append("<td style=\"vertical-align:top;\">");
			for(int i = 0; i < ids.length; i++) {
				switch(ids[i]) {
				case NAME:
					result.append("<a href=\"product.jsp?id=");
					result.append(rs.getInt(1));
					result.append("\"><b>");
					result.append(rs.getString(i + 3));
					result.append("</b></a>");
					break;
				case PRICE:
					result.append("<b>Price: </b>$");
					result.append(rs.getString(i + 3));
					break;
				case DESC:
					result.append(rs.getString(i + 3));
					break;
				case QUANT:
					result.append("<b>Quantity: </b>");
					result.append(rs.getInt(i + 3));
					break;
				case INV:
					result.append("<b>Inventory: </b>");
					result.append(rs.getInt(i + 3));
					break;
				case MERCH:
					result.append("<b>Merchant: </b>");
					result.append(rs.getString(i + 3));
					break;
				case ATTR:
					result.append("<b>Tags: </b>");
					//fetch via sql
					break;
				}
				result.append("<br>");
			}
			result.append("</td>");
			
		}
		
		return result.toString();
		
	}
	
}