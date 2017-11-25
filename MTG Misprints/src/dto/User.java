package dto;

public class User {
	
	public static final int GROUP_ERROR = -1;
	public static final int GROUP_FAILED_LOGIN = 0;
	public static final int GROUP_CUSTOMER = 1;
	public static final int GROUP_MERCHANT = 2;
	
	public final int userGroup;
	public final int suid;
	public final String name;
	
	public User(int userGroup, int suid, String name){
		if(0 < userGroup && userGroup < 3){
			this.userGroup = userGroup;
		}else{
			this.userGroup = 0;
		}
		
		this.suid = suid;
		this.name = name;
	}
	
	public static User getFailedLogin(){
		return new User(GROUP_FAILED_LOGIN, -1, null);
	}

}
