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

	/**
	 * 
	 * @param searchString The search string the user inputs, it will check the description and name for each search term delimited by a space
	 * @param attributes The ids of the attributes to filter on.
	 * @return A LinkedList containing every cardproduct matching all criteria.
	 */
	public static LinkedList<CardProduct> getSearchResults(String searchString, int[] attributes){
		LinkedList<CardProduct> cards = filterCardsByAttributes(attributes);
		if(searchString == null || searchString.length() == 0){
			return cards;
		}
		String[] parsedSearch = parseSearchString(searchString);
		Iterator<CardProduct> cardIter = cards.iterator();
		for(int i =0; i < parsedSearch.length; i++){
			parsedSearch[i] = parsedSearch[i].trim().toLowerCase();
		}
		while(cardIter.hasNext()){
			CardProduct currentCard = cardIter.next();
			for(String searchTerm: parsedSearch){
				if(!((currentCard.name.toLowerCase()).contains(searchTerm) || (currentCard.description.toLowerCase()).contains(searchTerm))){
					//Then the card does not contain the key word in its description or name, so discard it
					cardIter.remove();
					continue;
				}
			}
		}
		
		return cards;
	}
	
	
	
	private static LinkedList<CardProduct> filterCardsByAttributes(int[] attributes){
		LinkedList<CardProduct> cards = new LinkedList<CardProduct>();
		String candidateCards;
		ResultSet rs = null;
		if(attributes != null && attributes.length > 0){
			Arrays.sort(attributes);
			candidateCards = "SELECT * FROM HasAttribute, CardProduct"
					+ " WHERE HasAttribute.cardproductid = CardProduct.cardproductid"
					+ " AND inventory > 0"
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
							currentCard = CardProduct.getCard(rs);
							if(currentCard.inventory > 0){
								cards.add(currentCard);
							}
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
					CardProduct card = CardProduct.getCard(rs);
					if(card.inventory> 0){
						cards.add(card);
					}
				}
			}catch(SQLException e){
				e.printStackTrace(System.err);
			}catch(ClassNotFoundException e){
				e.printStackTrace(System.err);
			}
		}
		return cards;
	}
	
	private static String[] parseSearchString(String searchString){
		Scanner scanner = new Scanner(searchString);
		ArrayList<String> words = new ArrayList<String>();
		while(scanner.hasNext()){
			String s = scanner.next();
			if(s != null){
				s = s.trim();
				if(s.length() > 0){
					words.add(s);
				}
			}
			
		}
		
		return words.toArray(new String[0]);
	}
	
	public static void main(String[] args){
		int[] attributes = {};
		LinkedList<CardProduct> cards = getSearchResults("", attributes);
		for(CardProduct card : cards){
			System.out.println(card + "\n");
		}
	}

	
}
