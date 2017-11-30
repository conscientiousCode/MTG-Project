package pageutils;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Scanner;

import dto.CardProduct;

public class Search {

	public static LinkedList<CardProduct> getSearchResults(String searchString, int[] attributes){
		LinkedList<CardProduct> cards = filterCardsByAttributes(attributes);
		if(searchString == null || searchString.length() == 0){
			return cards;
		}
		String[] parsedSearch = parseSearchString(searchString);
		Iterator<CardProduct> cardIter = cards.iterator();
		
		while(cardIter.hasNext()){
			CardProduct currentCard = cardIter.next();
			for(String searchTerm: parsedSearch){
				if(!(currentCard.name.contains(searchTerm) || currentCard.description.contains(searchTerm))){
					//Then the card does not contain the key word in its description or name, so discard it
					cardIter.remove();
					continue;
				}
			}
		}
		
		return cards;
	}
	
	//Returns the current row as a card, assuming the rs contains rows we care about
	public static CardProduct getCard(ResultSet rs) throws SQLException{
		int cardproductid, merchantid;
		String name, description;
		BigDecimal price;
		int inventory;
		byte[] image;
		
		cardproductid = rs.getInt("cardproductid");
		merchantid = rs.getInt("merchantid");
		name = rs.getString("name");
		description = rs.getString("description");
		price = rs.getBigDecimal("price");
		inventory = rs.getInt("inventory");
		image = rs.getBytes("image");
		
		return new CardProduct(cardproductid, merchantid, name, description, price, inventory, image);
	}
	
	public static LinkedList<CardProduct> filterCardsByAttributes(int[] attributes){
		LinkedList<CardProduct> cards = new LinkedList<CardProduct>();
		String candidateCards;
		ResultSet rs = null;
		if(attributes != null && attributes.length > 0){
			Arrays.sort(attributes);
			candidateCards = "SELECT * FROM HasAttribute, CardProduct"
					+ " WHERE HasAttribute.cardproductid = CardProduct.cardproductid"
					+ " ORDER BY CardProduct.cardproductid ASC, cardattributeid ASC";
			try(Connection con = CommonSQL.getDBConnection();
					PreparedStatement pstmt = con.prepareStatement(candidateCards);){
				int currentCardId = 0;//Used to check if we are still in the same cards table range
				int attributeIndex = 0;//Used to keep track the next attribute we want to see
				int attributeId;//used to prevent repeated calls to the result set for the current rows cardattributeid
				rs = pstmt.executeQuery();
				CardProduct currentCard;
				while(rs.next()){
					if(rs.getInt("cardproductid") != currentCardId){//If we have entered a different card's range in the table
						currentCardId = rs.getInt("cardproductid");
						attributeIndex = 0;
					}
					
					attributeId = rs.getInt("cardattributeid");
					if(attributeIndex == attributes.length){
						continue;
					}else if(attributeId > attributes[attributeIndex]){
						//Since attributes are sequenced, if the rs jumps ahead, it is missing the one we need
						//We will keep hitting this until we get to the next cardId
						continue;
					}else if(attributeId < attributes[attributeIndex]){
						continue;//We are yet to reach a cardattribute we care about
					}else{//equivalent
						if((++attributeIndex) == attributes.length){//Then every attribute that we require has been present
							cards.add(getCard(rs));
						}
					}
				}
				
				
			}catch(SQLException e){
				e.printStackTrace(System.err);
			}catch(ClassNotFoundException e){
				e.printStackTrace(System.err);
			}
		}else{//Anycard could be the one we are looking for
			candidateCards = "SELECT * FROM CardProduct ORDER BY cardproductid ASC";
			try(Connection con = CommonSQL.getDBConnection();
					PreparedStatement pstmt = con.prepareStatement(candidateCards);){
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					cards.add(getCard(rs));
				}
			}catch(SQLException e){
				e.printStackTrace(System.err);
			}catch(ClassNotFoundException e){
				e.printStackTrace(System.err);
			}
		}
		return cards;
	}
	
	public static String[] parseSearchString(String searchString){
		Scanner scanner = new Scanner(searchString);
		ArrayList<String> words = new ArrayList<String>();
		while(scanner.hasNext()){
			words.add(scanner.next());
		}
		
		return words.toArray(new String[0]);
	}
	
	public static void main(String[] args){
		int[] attributes = {1,2,3};
		LinkedList<CardProduct> cards = getSearchResults("description", attributes);
		for(CardProduct card : cards){
			System.out.println(card);
		}
	}

	
}
