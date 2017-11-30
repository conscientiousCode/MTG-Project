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
	
	public String toString(){
		StringBuilder sb = new StringBuilder();
		sb.append("cardproductid: " + cardproductid);
		sb.append("\nmerchantid: " + merchantid);
		sb.append("\nname: " + name);
		sb.append("\ndescription: " + description);
		sb.append("\nprice: " + price);
		sb.append("\ninventory: " + inventory);
		sb.append("\nImage Present?: " + (image != null && image.length!= 0));
		
		return sb.toString();
	}
	
}
