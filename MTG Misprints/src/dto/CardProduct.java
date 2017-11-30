package dto;

import java.awt.Image;
import java.math.BigDecimal;

public class CardProduct {

	public final int cardproductid, merchantid;
	public final String name, description;
	public final BigDecimal price;
	public final int inventory;
	public final byte[] image;
	
	public CardProduct(int cardproductid, int merchantid, String name, String description, BigDecimal price, int inventory, byte[] image){
		this.cardproductid = cardproductid;
		this.merchantid = merchantid;
		this.name = name;
		this.description = description;
		this.price = price;
		this.inventory = inventory;
		this.image = image;
	}
	
	
	
}
