package pageutils;
/*LOTS OF CODE Taken from https://www.tutorialspoint.com/jsp/jsp_sending_email.htm*/
/*javax.mail.jar is an open source project at https://javaee.github.io/javamail/#Download_JavaMail_Release*/
/*I also copied some other code from tack exchange*/
import java.sql.*;
import java.io.*;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
import javax.servlet.http.*;
import javax.servlet.*;

public class Email {
	private static final String USERNAME = "UBCOCOSC304Customer1@gmail.com";
	private static final String PASSWORD = "agreatpassword";
	
	public static boolean sendPasswordRecoveryEmail(String userEmail){
			//Check email user sent is in the database
			if(userEmail == null || userEmail.length() ==0){
				return false; 
			}
			userEmail = userEmail.trim();
			if(!emailInDatabase(userEmail)){
				return false;
			}
			
			String userPassword = getPasswordForUser(userEmail);
			if(userPassword == null){
				return false;
			}

		        Properties props = new Properties();
		        props.put("mail.smtp.auth", "true");
		        props.put("mail.smtp.starttls.enable", "true");
		        props.put("mail.smtp.host", "smtp.gmail.com");
		        props.put("mail.smtp.port", "587");

		        Session session = Session.getInstance(props,
		          new javax.mail.Authenticator() {
		            protected PasswordAuthentication getPasswordAuthentication() {
		                return new PasswordAuthentication(USERNAME, PASSWORD);
		            }
		          });
		        
		        try {

		            Message message = new MimeMessage(session);
		            message.setFrom(new InternetAddress(USERNAME));
		            message.setRecipients(Message.RecipientType.TO,
		                InternetAddress.parse(userEmail));
		            message.setSubject("MTG Mistprints password");
		            message.setText("Your MTG Mistprints password: " + userPassword);

		            Transport.send(message);

		            System.out.println("Done");
		            return true;
		        } catch (MessagingException e) {
		            throw new RuntimeException(e);
		        }
	}
	
	private static boolean emailInDatabase(String email){
		if(email == null || email.length() == 0){
			return false;
		}
		email = email.trim();
		
		String sql = "Select Count(1) as present From SiteUser Where email = ?";
		try(Connection con = CommonSQL.getDBConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setString(1, email);
			ResultSet rs = pstmt.executeQuery();
			if( rs.next() && rs.getInt("present") == 1){
				return true;
			}else{
				return false;
			}
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
	
	private static String getPasswordForUser(String email){
		if(email == null || email.length() == 0){
			return null;
		}
		email = email.trim();
		String sql = "Select password From SiteUser Where email = ?";
		try(Connection con = CommonSQL.getDBConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setString(1, email);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()){
				return rs.getString("password");
			}else{
				return null;
			}
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return null;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public static void main(String[] args){
		System.out.println(emailInDatabase("UBCOCOSC304Customer1@gmail.com"));
		System.out.println(getPasswordForUser("UBCOCOSC304Customer1@gmail.com"));
		System.out.println(sendPasswordRecoveryEmail("UBCOCOSC304Customer1@gmail.com"));
	}
}
