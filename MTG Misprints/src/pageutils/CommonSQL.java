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
	
	public static String getImageSourceForProduct(int id){
		String sql = "Select image FROM CardProduct WHERE cardproductid = ?";
		
		try(Connection con = getDBConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next() && rs.getBlob("image") != null){
				return "downloadServlet?cardproductid=" + id;
			}else{
				return "res/cardnoimage.png";
			}
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "res/cardnoimage.png";
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "res/cardnoimage.png";
		}
	}
}
