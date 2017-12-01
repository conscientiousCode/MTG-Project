package pageutils;

public class Customer {
	//ALL ARE NOT NULL
	String email, password; 
	String firstName, lastName, address, city, province, postalCode;
	public static final int ML_EMAIL = 50, ML_PASSWORD = 30, ML_FIRST_NAME = 20, ML_LAST_NAME = 30, ML_ADDRESS = 50, ML_CITY = 25, RL_PROVINCE = 2, RL_POSTAL_CODE = 6;
	public static final String[] PROVINCES = {"BC", "AB", "SK", "MB", "ON", "QB", "NB", "NS", "PI", "NL", "YK", "NW", "NV"};
	
	private Customer(String email, String password, String firstName, String lastName, String address, String city, String province, String postalCode){
		this.email = email;
		this.password = password;
		this.firstName = firstName;
		this.lastName = lastName;
		this.address = address;
		this.city = city;
		this.province = province;
		this.postalCode = postalCode;
	}
	
	/*Returns null if any field is outside of the required bounds*/
	public static Customer getNewCustomer(String email, String password, String firstName, String lastName, String address, String city, String province, String postalCode){
		String[] allElements = {email,password, firstName, lastName, address, city, province, postalCode};
		
		if(requiredFieldIsNullOrEmpty(allElements)){
			return null;
		}
		
		if(!allStringLengthsAreValid(email,password, firstName, lastName, address, city, province, postalCode)){
			return null;
		}
		
		if(!isAProvince(province)){
			return null;
		}
		postalCode = postalCode.toUpperCase();
		if(!checkPostalCodeSequenceIsValid(postalCode)){
			return null;
		}
		if(!emailIsWellFormed(email)){
			return null;
		}
		
		return new Customer(email,password, firstName, lastName, address, city, province, postalCode);
	}
	
	private static boolean requiredFieldIsNullOrEmpty(String[] values){
		for(String s: values){
			if(s == null || s.length() ==0){
				return false;
			}
		}
		return true;
	}
	
	private static boolean allStringLengthsAreValid(String email, String password, String firstName, String lastName, String address, String city, String province, String postalCode){
		return(email.length() <= ML_EMAIL
				&& password.length() <= ML_PASSWORD
				&& firstName.length() <= ML_FIRST_NAME
				&& lastName.length() <= ML_LAST_NAME
				&& address.length() <= ML_ADDRESS
				&& city.length() <= ML_CITY
				&& province.length() == RL_PROVINCE
				&& postalCode.length() == RL_POSTAL_CODE);
	}
	
	public static boolean isAProvince(String province){
		for(String s : PROVINCES){
			if(province.equals(s)){
				return true;
			}
		}
		return false;
	}
	
	public static boolean checkPostalCodeSequenceIsValid(String postalCode){
		if(postalCode == null || postalCode.length() != RL_POSTAL_CODE){
			return false;
		}
		postalCode = postalCode.toUpperCase();
		for(int i = 0; i <3; i++){//Pairwise check that the sequence is Letter Number, Letter Number, Letter Number
			if('A' > postalCode.charAt(2*i) || 'Z' < postalCode.charAt(2*i)
				|| '0' > postalCode.charAt(2*i +1) ||	'9' < postalCode.charAt(2*i + 1)){
				return false;
			}
		}
		return true;
	}
	
	public static boolean emailIsWellFormed(String email){
		if(email == null){
			return false;
		}
		String regex = "\\w+[@]\\w+[.]\\w+";
		return email.matches(regex);
	}
	
	private static boolean isLetterOrNumber(char c){
		String s = "c";
		s = s.toUpperCase();
		c = s.charAt(0);
		if('A' > c || 'Z' < c || '0' > c ||	'9' < c){
			return false;
		}else{
			return true;
		}
	}
	
	public static void main(String[] args){
		
	}
	
}