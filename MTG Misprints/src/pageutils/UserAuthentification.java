package pageutils;
import java.sql.*;
import dto.User;

public class UserAuthentification {
	
	
	final static String url = "jdbc:mysql://cosc304.ok.ubc.ca/group2";
	final static String uid = "group2";
	final static String pw = "group2";
	
	
	/* Validates login credentials and returns a user object that countains their user group, suid, and name
	 * */
	public static User authenticate(String userName, String password){
		try(Connection con = DriverManager.getConnection(url, uid, pw);
				PreparedStatement pstmt = con.prepareStatement(
					  "SELECT *" 
					+ "FROM SiteUser"
					+ "WHERE email = ? AND password = ?");
				){
			pstmt.setString(1, userName);
			pstmt.setString(2, password);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()){
				
				String sql = "Select * FROM Customer WHERE custid = ?";
				PreparedStatement userGroupStmt = con.prepareStatement(sql);
				pstmt.setInt(1, rs.getInt("suid"));
				rs = pstmt.executeQuery();
				if(rs.next()){//user is a customer
					userGroupStmt.close();
					return new User(User.GROUP_CUSTOMER, rs.getInt("custid"), rs.getString("firstname"));
					
				}else{
					sql = "Select * FROM Merchant WHERE custid = ?";
					userGroupStmt = con.prepareStatement(sql);
					pstmt.setInt(1, rs.getInt("suid"));
					rs = pstmt.executeQuery();
					if(rs.next()){//user is a merchant
						userGroupStmt.close();
						return new User(User.GROUP_MERCHANT, rs.getInt("suid"), rs.getString("merchantname"));
					}else{//else UNHANDLED USER
						throw new SQLException("UNHANDLED USER TABLE FOR AUTHENTICATION");
					}
				}
						
			}else{
				return User.getFailedLogin();
			}
			
			
		}catch(SQLException e){
			System.out.println(e.getStackTrace());
			return null;
		}
		
	}
	

}
