package pageutils;

import java.sql.ResultSet;
import java.sql.SQLException;
import dto.*;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedList;

import java.sql.*;



public class CardInfo {

	public static final int IGNORE = -1;
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
			result.append("<img src=");
			// TODO: images via sql
			result.append(CommonSQL.getImageSourceForProduct(rs.getInt("cardproductid")));
			result.append(" style=\"max-width:150px; max-height:150px; display: block; margin:auto;\">");
			result.append("</a>");
			result.append("</td>");
			
			result.append("<td style=\"vertical-align:top;\">");
			for(int i = 0; i < ids.length; i++) {
				switch(ids[i]) {
				case IGNORE:
					break;
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
	
public static String getCardInfo(LinkedList<CardProduct> cards) throws SQLException {
		
		StringBuilder result = new StringBuilder();
		Iterator<CardProduct> card = cards.iterator();
		while(card.hasNext()) {
			CardProduct currentCard = card.next();
			result.append("<tr>");
			result.append("<td style=\"width:150px; vertical-align:top;\">");
			result.append("<a href=\"product.jsp?id=");
			result.append(currentCard.cardproductid);
			result.append("\">");
			result.append("<img src=");
			
			result.append(CommonSQL.getImageSourceForProduct(currentCard.cardproductid));
			result.append(" style=\"max-width:150px; max-height:150px; display: block; margin:auto;\">");
			result.append("</a>");
			result.append("</td>");
			
			result.append("<td style=\"vertical-align:top;\">");
			//NAME
			result.append("<a href=\"product.jsp?id=");
			result.append(currentCard.cardproductid);
			result.append("\"><b>");
			result.append(currentCard.name);
			result.append("</b></a>");
			result.append("<br>");
			//Merchant
			//result.append("<b>Merchant: </b>");
			//TODO fetch merchant from name from sql
			
			//PRICE
			result.append("<b>Price: </b>$");
			result.append(currentCard.price);
			result.append("<br>");
			//Inventory
			result.append("<b>Quantity: </b>");
			result.append(currentCard.inventory);
			result.append("<br>");
			//Attributes
			//TODO fetch from SQL
			String[] attributes = getAttributesForCard(currentCard.cardproductid);
			if(attributes != null){
				
				for(String attribute : attributes){
					result.append("<a href=\"searchresults.jsp?"+attribute+"=" + attribute);
					result.append("\">");
					result.append(attribute);
					result.append("</a>  ");
				}
			}
			result.append("<br>");
		}
			result.append("</td>");
			
		
		return result.toString();
		
	}
	
	private static String[] getAttributesForCard(int cardproductid){
		if(cardproductid< 1){
			return null;
		}
		
		String sql = "SELECT DISTINCT a.name FROM CardProduct as p, HasAttribute as h, CardAttribute as a"
				+ " WHERE ? = h.cardproductid AND h.cardattributeid = a.cardattributeid";
		
		try(Connection con = CommonSQL.getDBConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
				pstmt.setInt(1, cardproductid);
			
			ResultSet rs = pstmt.executeQuery();
			
			ArrayList<String> attributes = new ArrayList<String>();
			while(rs.next()){
				attributes.add(rs.getString("name"));
			}
			return attributes.toArray(new String[0]);
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}
	
}