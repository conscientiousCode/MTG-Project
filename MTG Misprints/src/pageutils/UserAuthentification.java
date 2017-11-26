package pageutils;
import java.sql.*;
import pageutils.CommonSQL;
import dto.User;

public class UserAuthentification {
	
	
	private final static String url = "jdbc:mysql://cosc304.ok.ubc.ca/group2";
	private final static String uid = "group2";
	private final static String pw = "group2";
	
	public static boolean testConnection() throws ClassNotFoundException{
		Class.forName("com.mysql.jdbc.Driver");
		try(Connection con = CommonSQL.getDBConnection()){
			return true;
		}catch(SQLException e){
			e.printStackTrace(System.out);
			return false;
		}
	}
	
	/* Validates login credentials and returns a user object that countains their user group, suid, and name
	 * */
	public static User authenticate(String userName, String password) throws ClassNotFoundException{
		Class.forName("com.mysql.jdbc.Driver");//REQUIRED TO FORCE LOAD DRIVER
		try(Connection con = CommonSQL.getDBConnection();
				PreparedStatement pstmt = con.prepareStatement(
					  "SELECT *" 
					+ " FROM SiteUser"
					+ " WHERE email = ? AND password = ?");
				){
			pstmt.setString(1, userName);
			pstmt.setString(2, password);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()){
				int suid = rs.getInt("suid");
				String name;
				String sql = "Select * FROM Customer WHERE custid = ?";
				PreparedStatement userGroupStmt = con.prepareStatement(sql);
				userGroupStmt.setInt(1, suid);
				rs = userGroupStmt.executeQuery();
				System.out.println("Entry found mathing: " + suid);
				if(rs.next()){//user is a customer
					name = rs.getString("firstname");
					userGroupStmt.close();
					return new User(User.GROUP_CUSTOMER, suid, name);
					
				}else{
					sql = "Select * FROM Merchant WHERE suid = ?";
					userGroupStmt = con.prepareStatement(sql);
					userGroupStmt.setInt(1, suid);
					rs = userGroupStmt.executeQuery();
					if(rs.next()){//user is a merchant
						name = rs.getString("merchantname");
						userGroupStmt.close();
						return new User(User.GROUP_MERCHANT, suid, name);
					}else{//else UNHANDLED USER
						throw new SQLException("UNHANDLED USER TABLE FOR AUTHENTICATION");
					}
				}
						
			}else{
				return User.getFailedLogin();
			}
			
			
		}catch(SQLException e){
			e.printStackTrace(System.out);
			return null;
		}
		
	}
	

}
