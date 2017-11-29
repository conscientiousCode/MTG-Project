package pageutils;
import java.util.ArrayList;

import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import java.math.BigDecimal;
import java.sql.*;
import dto.User;
import dto.CartItem;

public class Cart extends ArrayList<CartItem> implements HttpSessionBindingListener{
	
	private final User user;
	public Cart(User user){
		super();
		this.user = user;
	}
	
	public Cart[] toArray(){
		return super.toArray(new Cart[0]);
	}
	
	/*If cart sizes become large with lots of additions, update how carts store data*/
	/**
	 * 
	 * @param item the item to be added. if the cart already contains some of this item, quantities are added.
	 */
	public void addItemToCart(CartItem item){
		for(int i = 0; i < this.size(); i++){
			CartItem inCart = this.get(i);
			if(inCart.productid == item.productid){
				inCart.quantity+= item.quantity;
				return;
			}
		}
		//else no item in the cart
		this.add(item);
	}
	
	
	@Override
	public void valueBound(HttpSessionBindingEvent arg0) {
		//Doesnt need to do anything
		
	}
	@Override
	public void valueUnbound(HttpSessionBindingEvent arg0) {
		writeCartToDatabase(user, this);
	}
	
	
	/**
	 * 
	 * @param user to whom the cart belongs
	 * @return null if error, other wise what ever was even in their cart (possibly empty Cart)
	 */
	private static Cart getCartFromDatabase(User user){
		if(user == null){
			return null;
		}
		String getQuantities = "SELECT DISTINCT CardProduct.cardproductid, name, price, quantity "
				+ " FROM CardProduct, (SELECT quantity, cardproductid FROM Customer, InCart WHERE InCart.custid = ?) as A "
				+ " WHERE A.cardproductid = CardProduct.cardproductid";
		
		try(Connection con = CommonSQL.getDBConnection()){
			PreparedStatement pstmt = con.prepareStatement(getQuantities);
			pstmt.setInt(1, user.suid);
			ResultSet rs = pstmt.executeQuery();
			Cart cart = new Cart(user);
			int prodId;
			String name;
			BigDecimal price;
			int quantity;
			
			while(rs.next()){
				prodId = rs.getInt("cardproductid");
				name = rs.getString("name");
				price = rs.getBigDecimal("price");
				quantity = rs.getInt("quantity");
				
				cart.add(new CartItem(prodId, name, price, quantity));
			}
			pstmt.close();
			return cart;
			
		}catch(SQLException e){
			System.err.println("Could not retrieve data: SQLException");
			e.printStackTrace(System.err);
			return null;
		}catch(ClassNotFoundException e){
			System.err.println("Could not find a suitable driver to connect to the database: ");
			e.printStackTrace(System.err);
			return null;
		}
	}
	
	public static boolean writeCartToDatabase(User user, Cart cart){
		if(user == null){
			throw new IllegalArgumentException("No user specified to update their cart in the database");
		}
		if(user.userGroup != User.GROUP_CUSTOMER){
			return false;
		}
		if(cart == null || cart.size() == 0){
			return true;
		}
		
		String writeCartToDatabase = "INSERT INTO InCart (custid, cardproductid, quantity) VALUES (?,?,?)";
		
		try(Connection con = CommonSQL.getDBConnection()){
			PreparedStatement pstmt = con.prepareStatement(writeCartToDatabase);
			
			for(CartItem item : cart){
				if(item.quantity > 0){//business rule
					pstmt.setInt(1, user.suid);
					pstmt.setInt(2, item.productid);
					pstmt.setInt(3, item.quantity);
					pstmt.execute();
				}
			}
			return true;
		}catch(SQLException e){
			System.err.println("Could send request to database: SQLException");
			e.printStackTrace(System.err);
			return false;
		}catch(ClassNotFoundException e){
			System.err.println("Could not find a suitable driver to connect to the database: ");
			e.printStackTrace(System.err);
			return false;
		}
		
	}
	
	
	/*If the cart passed in is not null or empty, then just return that cart, database user cart entries
	 * Otherwise, retrieve their cart from last session.
	 * */
	public static Cart syncSessionCarts(User user, Cart preCart){
		if(preCart != null && preCart.size() > 0){
			Cart copy = new Cart(user);
			for(CartItem item : preCart){
				copy.add(item);
			}
			return copy;
		}
		Cart postCart = getCartFromDatabase(user);
		deleteOldUserCart(user);
		//DEBUG: printCartToConsole(postCart);
		return postCart;
	}
	
	/**
	 * 
	 * @param user who's cart to delete. If null or someone without a cart, do nothing.
	 */
	private static void deleteOldUserCart(User user){
		if(user == null){return;}
		
		String deleteUserCart = "DELETE FROM InCart WHERE custid = ?";
		
		try(Connection con = CommonSQL.getDBConnection()){
			PreparedStatement pstmt = con.prepareStatement(deleteUserCart);
			pstmt.setInt(1, user.suid);
			pstmt.execute();
			pstmt.close();
			
		}catch(SQLException e){
			System.err.println("Could send request to database: SQLException");
			e.printStackTrace(System.err);
		}catch(ClassNotFoundException e){
			System.err.println("Could not find a suitable driver to connect to the database: ");
			e.printStackTrace(System.err);
		}
	}
	
	/**
	 * 
	 * @param cardproductid the id of the item requested
	 * @param quantityRequested How many of the item they want
	 * @return A CartItem of the product with a quantity as close as possible to the requested without going over the merchants inventory.
	 *	If no such item or some exception, return null;
	 */
	public static CartItem getCartItemFor(int cardproductid, int quantityRequested){
		
		String getCard = "SELECT cardproductid, name, price, inventory FROM CardProduct WHERE cardproductid = ?";
		
		
		try(Connection con = CommonSQL.getDBConnection()){
			PreparedStatement pstmt = con.prepareStatement(getCard);
			pstmt.setInt(1, cardproductid);
			ResultSet rs = pstmt.executeQuery();
			
			String name;
			BigDecimal price;
			int inventory, quantityGiven;
			
			if(rs.next()){
				inventory = rs.getInt("inventory");
				quantityGiven = (inventory > quantityRequested)?(quantityRequested):(inventory);
				name = rs.getString("name");
				price = rs.getBigDecimal("price");
				
				pstmt.close();
				return new CartItem(cardproductid, name, price, quantityGiven);
			}else{
				pstmt.close();
				return null;//No such product
			}
		}catch(SQLException e){
			System.err.println("Could send request to database: SQLException");
			e.printStackTrace(System.err);
			return null;
		}catch(ClassNotFoundException e){
			System.err.println("Could not find a suitable driver to connect to the database: ");
			e.printStackTrace(System.err);
			return null;
		}
	}
	
	private static void printCartToConsole(Cart cart){
		System.out.println("prodId,  name,   price,   quantity");
		for(CartItem item : cart){
			System.out.println("" + item.productid + ",  " + item.name + ",  " + item.price.toString() + ",  " + item.quantity);
		}
	}
	
	public static void main(String[] args){
		System.out.println(getCartItemFor(1,6));
	}
	
}
