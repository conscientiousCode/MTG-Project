package pageutils;
import java.util.ArrayList;
import dto.CartItem;

public class Cart extends ArrayList<CartItem>{
	
	public Cart(){
		super();
	}
	public Cart(int initCapacity){
		super(initCapacity);
	}
	
	public Cart[] toArray(){
		return super.toArray(new Cart[0]);
	}
}
