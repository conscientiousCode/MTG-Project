package dto;
import java.math.BigDecimal;

public class CartItem {
	
	public final int productid;
	public final String name;
	public final BigDecimal price;
	//Add image data here later, set to null in the more basic constructor.
	public int quantity;
	
	
	public CartItem(int productid, String name, BigDecimal price, int quantity){
		if(productid < 1){
			throw new IllegalArgumentException("productid passed in is less than 1 and thus has no entry in the database");
		}
		if(price.compareTo(BigDecimal.ZERO) < 0){//negative price
			throw new IllegalArgumentException("No product should have a negative price");
		}
		if(quantity < 1){
			throw new IllegalArgumentException("Given quantity less than 1, you cannot have less than one object in your cart.");
		}
		
		this.productid = productid;
		this.name = (name == null)?(""):(name);
		this.price = price;
		this.quantity = quantity;
		
	}
	
	public String toString(){
		StringBuilder item = new StringBuilder();
		item.append("Product Id: "+ productid + "\n");
		item.append("Name: "+ name + "\n");
		item.append("Price: "+ price + "\n");
		item.append("quantity: "+ quantity + "\n");
		return item.toString();
	}
}
