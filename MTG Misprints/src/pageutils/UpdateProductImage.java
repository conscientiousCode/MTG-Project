package pageutils;
/*This code is essentially copied from http://www.codejava.net/coding/upload-files-to-database-servlet-jsp-mysql
 * These peoples terms of use
 * */

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.math.BigDecimal;

@WebServlet("/uploadServlet")
@MultipartConfig(maxFileSize = 16177215)    // upload file's size up to 16MB
public class UpdateProductImage extends HttpServlet{
	public static final int MAX_IMAGE_SIZE = 1000000;
	
	 public void doPost(HttpServletRequest request,
	            HttpServletResponse response) throws ServletException, IOException {
	        // gets values of text fields
	        
		 
	        InputStream inputStream = null; // input stream of the upload file
	         
	        // obtains the upload file part in this multipart request
	        Part filePart = request.getPart("image");
	        if (filePart != null) {
	            if(filePart.getSize() > MAX_IMAGE_SIZE){
	            	response.sendRedirect("addproduct.jsp?errormessage=imagetoolarge");
	            	return;
	            }
	            
	            // obtains input stream of the upload file
	            inputStream = filePart.getInputStream();
	        }
	        
	        int merchantid = Integer.parseInt(request.getParameter("merchantid"));
	        String name = request.getParameter("name");
	        BigDecimal price;
	        try{
	        	price = new BigDecimal(request.getParameter("price"));
	        }catch(NumberFormatException e){
	        	response.sendRedirect("addproduct.jsp?errormessage=priceisNAN");
	        	return;
	        };
	        if(price.compareTo(BigDecimal.ZERO) < 0){
	        	response.sendRedirect("addproduct.jsp?errormessage=pricelessthanzero");
	        	return;
	        }
	        
	        int inventory = Integer.parseInt(request.getParameter("inventory"));
	        if(inventory < 0){
	        	response.sendRedirect("addproduct.jsp?errormessage=inventorylessthanzero");
	        	return;
	        }
	        String description = request.getParameter("description");
	        
	        String message = null;
	        
	        String sql = "INSERT INTO CardProduct (merchantid, name, price, inventory, description, image) VALUES (?,?,?,?,?,?)";
	        try (Connection con = CommonSQL.getDBConnection();
	        		PreparedStatement pstmt = con.prepareStatement(sql)){
	        	
	        	pstmt.setInt(1, merchantid);
	        	pstmt.setString(2, name);
	        	pstmt.setBigDecimal(3, price);
	        	pstmt.setInt(4, inventory);
	        	pstmt.setString(5,description);
	        	
	            if (inputStream != null) {
	                // fetches input stream of the upload file for the blob column
	                pstmt.setBlob(6, inputStream);
	            }
	 
	            // sends the statement to the database server
	            int row = pstmt.executeUpdate();
	            if (row > 0) {
	                message = "File uploaded and saved into database";
	            }
	        } catch (SQLException ex) {
	            message = "ERROR: " + ex.getMessage();
	            ex.printStackTrace();
	        } catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
	        
	        response.sendRedirect("storeinfo.jsp");
	        
	    }
}
