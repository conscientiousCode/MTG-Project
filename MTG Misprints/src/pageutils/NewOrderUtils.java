package pageutils;
import dto.CardProduct;
import dto.CartItem;

import java.math.BigDecimal;
import java.sql.*;

import java.util.IllegalFormatException;

public class NewOrderUtils {
	
	private static final int CREDIT_CARD_NUMBER_SIZE = 16;
	
	//Parses creditcard numbers, ignores characters ' ' and '-'. If any other characters but numeric exist in the string, then exception
	//String must contain exactly CREDIT_CARD_NUMBER_SIZE numeric characters to be considered valid
	public static String parseCreditCard(String cardNumber)throws IllegalArgumentException{
		//All creditcards have exactly 16 numbers
		if(cardNumber.length() > 30){
			throw new IllegalArgumentException("Length of input is too long: > 30");
		}
		StringBuilder parsedCardNumber = new StringBuilder(16);
		int numberOfNumbersInCard = 0;
		for(char c : cardNumber.toCharArray()){
			if('0' <= c && c <= '9'){
				parsedCardNumber.append(c);
				if((++numberOfNumbersInCard) > CREDIT_CARD_NUMBER_SIZE){
					throw new IllegalArgumentException("Too many numbers present in the stirng");
				}
			}else if(c == '-' || c == ' '){
				continue;
			}else{
				throw new IllegalArgumentException("Unexpected character in input");
			}
		}
		if(numberOfNumbersInCard == CREDIT_CARD_NUMBER_SIZE){
			return parsedCardNumber.toString();
		}else{
			throw new IllegalArgumentException("Not enough numbers in the string for a credit card");
		}
	}
	
	//https://stackoverflow.com/questions/22929237/convert-java-time-localdate-into-java-util-date-type
	public static boolean creditCardDateValid(java.util.Date cardExpireyDate){
		//There are too many date time formats in java....
		java.util.Date today = java.util.Date.from(java.time.LocalDate.now().atStartOfDay(java.time.ZoneId.systemDefault()).toInstant());
		return 0 <= today.compareTo(cardExpireyDate);
	}
	
	//Returns a cart containing as many of each item type as possible to be valid for the order.
	//Checks price and inventory, if inventory > quantity wanted, update quantity to the amount that we have
	//It is possible that if this runs when someone checks out, the values will be wrong.
	public static Cart validateCartQuantities(Cart userCart){
		Cart validCart = new Cart(userCart.getUser());
		String getItem = "SELECT * FROM CardProduct WHERE cardproductid = ?";
		for(CartItem item : userCart){
			try(Connection con = CommonSQL.getDBConnection();
					PreparedStatement pstmt = con.prepareStatement(getItem)){
				pstmt.setInt(1, item.productid);
				
				ResultSet rs = pstmt.executeQuery();
				CardProduct product = CardProduct.getCard(rs);
				int newQuantity;
				BigDecimal newPrice = product.price;
				if(product.inventory == 0){
					continue;//There is no stock left, so remove it from the validated cart
				}else if(item.quantity > product.inventory){
					newQuantity =product.inventory;
				}else{
					newQuantity = item.quantity;
				}
				
				validCart.add(new CartItem(item.productid, item.name, newPrice, newQuantity));
				
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return validCart;
	}
	
	public static void main(String[] args){
		
	}
}
