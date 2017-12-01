package pageutils;

import java.sql.*;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;

public class ParseSearchRequest {

	public static int[] getAttributes(HttpServletRequest request){
		String sql = "SELECT cardattributeid, name FROM CardAttribute";
		ArrayList<Integer> attributes = new ArrayList<Integer>();
		try(Connection con =  CommonSQL.getDBConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
				if(request.getParameter(rs.getString("name")) != null){//If an attribute of this unique name was passed in
					attributes.add(rs.getInt("cardattributeid"));
				}
			}
			int[] returnArray = new int[attributes.size()];
			for(int i = 0; i < attributes.size(); i++){
				returnArray[i] = attributes.get(i);
			}
			return returnArray;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return null;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}
	
}
