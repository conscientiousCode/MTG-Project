package pageutils;
import dto.User;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class SessionBehaviour implements HttpSessionAttributeListener{
	
	private final User user;
	public SessionBehaviour(User user){
		this.user = user;
	}

	@Override
	public void attributeAdded(HttpSessionBindingEvent event) {
		// TODO Auto-generated method stub
		
	}
	
	//https://www.mkyong.com/servlet/a-simple-httpsessionattributelistener-example/
	@Override
	public void attributeRemoved(HttpSessionBindingEvent event) {
		String attributeName = event.getName();
		if(attributeName.equals("cart")){
			Cart cart = (Cart)event.getValue();
			Cart.writeCartToDatabase(user, cart);
		}
		
		
	}

	@Override
	public void attributeReplaced(HttpSessionBindingEvent event) {
		// TODO Auto-generated method stub
		
	}

	

}
