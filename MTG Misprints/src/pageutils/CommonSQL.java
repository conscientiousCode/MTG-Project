package pageutils;
import java.sql.*;

public class CommonSQL {

	private final static String url = "jdbc:mysql://cosc304.ok.ubc.ca/group2";
	private final static String uid = "group2";
	private final static String pw = "group2";
	
	public static Connection getDBConnection() throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager.getConnection(url,uid,pw);
	}
}
