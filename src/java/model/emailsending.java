/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author CS0064TX
 */
package model;
import java.io.UnsupportedEncodingException;
import java.util.Properties;
import javax.activation.*;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;



public class emailsending {
    
  
    
    public void send2(String cemail, String name) throws UnsupportedEncodingException {

    final String username = "tk.java.pharmacy@gmail.com"; //my email
    final String password = "javamodule@ply7";

    Properties props = new Properties();
    props.put("mail.smtp.auth", true);
    props.put("mail.smtp.starttls.enable", true);
    props.put("mail.smtp.host", "smtp.gmail.com");
    props.put("mail.smtp.port", "587");

    Session session = Session.getInstance(props, new javax.mail.Authenticator() {
    @Override
    protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(username, password);
    }                            
});

    try {
        
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress("tk.java.pharmacy@gmail.com","iPet Sri Lanka"));//ur email
        message.setRecipients(Message.RecipientType.TO,
                InternetAddress.parse(cemail));//u will send to
        message.setSubject("Dear "+name);    
        message.setText("");
        MimeBodyPart messageBodyPart = new MimeBodyPart();
        Multipart multipart = new MimeMultipart();


     
     
    //attached 1 --------------------------------------------
        String file = "D:\\iPET\\src\\java\\report\\report.pdf";
        String fileName = "report.pdf";
    messageBodyPart = new MimeBodyPart();   
    DataSource source = new FileDataSource(file);      
    messageBodyPart.setDataHandler(new DataHandler(source));
    messageBodyPart.setFileName(fileName);
    multipart.addBodyPart(messageBodyPart);
    
    
        message.setContent(multipart);

       
        System.out.println("sending");
        Transport.send(message);
        System.out.println("Done");
        
   

            
}catch (MessagingException e) {
        e.printStackTrace();
    }
  }
   
}
