package pageutils;
import java.sql.*;

public class Customer {
	//ALL ARE NOT NULL
	public String email, password; 
	public String firstName, lastName, address, city, province, postalCode;
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
				return true;
			}
		}
		return false;
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
		String regex = "\\w+[@]\\w+[.][a-zA-Z]+";
		return email.matches(regex);
	}
	
	
	public static boolean insertNewCustomer(Customer customer){
		int suid = insertIntoSuid(customer.email, customer.password);
		if(suid < 0){
			return false;
		}
		
		String sql = "INSERT INTO Customer (custid,firstname, lastname, address, city, province, postalcode) VALUES (?,?,?,?,?,?,?)";
		try(Connection con = CommonSQL.getDBConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
				pstmt.setInt(1, suid);
				pstmt.setString(2, customer.firstName);
				pstmt.setString(3, customer.lastName);
				pstmt.setString(4, customer.address);
				pstmt.setString(5, customer.city);
				pstmt.setString(6, customer.province);
				pstmt.setString(7, customer.postalCode);
				
				int success = pstmt.executeUpdate();
				if(success > 0){
					return true;
				}else{
					removeSiteUser(suid);
					return false;
				}
		} catch (ClassNotFoundException e) {
			removeSiteUser(suid);
			e.printStackTrace();
			return false;
		} catch (SQLException e) {
			removeSiteUser(suid);
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
	
	private static int insertIntoSuid(String email, String password){
		String sql = "INSERT INTO SiteUser (email, password) VALUES (?,?)";
		
		try(Connection con = CommonSQL.getDBConnection();
				PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)){
			pstmt.setString(1, email);
			pstmt.setString(2, password);
			pstmt.executeUpdate();
			
			ResultSet rs = pstmt.getGeneratedKeys();
		    if(rs.next()){
		    	return rs.getInt(1);
		    }else{
		    	return -1;
		    }
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -1;
		}
	}
	
	private static boolean removeSiteUser(int suid){
		String sql = "DELETE FROM SiteUser WHERE suid = ?";
		try(Connection con = CommonSQL.getDBConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setInt(1, suid);
			
			return pstmt.executeUpdate() > 0;
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
	
	public static void main(String[] args){
		System.out.println(emailIsWellFormed("danielherman@hotmail.ca"));
	}
	
}
