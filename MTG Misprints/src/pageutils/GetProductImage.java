package pageutils;
/*https://www.sitepoint.com/community/t/displaying-images-from-the-database-using-java-and-mysql/3454
 * I referenced the above page for the general way in which to write this code.
 * */

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/downloadServlet")
public class GetProductImage extends HttpServlet{
	
	public void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
		
		int cardproductid = Integer.parseInt(request.getParameter("cardproductid"));
		String getImage = "SELECT image FROM CardProduct WHERE cardproductid = ?";
		
		try(Connection con = CommonSQL.getDBConnection();
				PreparedStatement pstmt = con.prepareStatement(getImage)){
			
			pstmt.setInt(1, cardproductid);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()){
				String testLength = rs.getString("image");
				if(testLength == null){
				}
				byte[] image = new byte[testLength.length()];
				InputStream imageInput = rs.getBinaryStream("image");
				imageInput.read(image, 0, image.length);
				
				response.setContentType("image/jpeg");
				response.setContentLength(image.length);
				response.getOutputStream().write(image);
				
				request.setAttribute("image", image);
			}else{//No cardproduct found.
				System.out.println("Using as a nother marker");
				return;
			}
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
