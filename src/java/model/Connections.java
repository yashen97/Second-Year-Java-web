package model;
import java.sql.*;

public class Connections {
   static public Connection con;
   public Statement qry, qry1;
   public ResultSet rs;
   
   public void Connect(){
       //Making database connection Constructor
       try{ 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ipet","root","");
            qry = con.createStatement();
             System.out.println("Connected");
       }
       catch(Exception ex){
           System.out.println("Please connect to the server");
       }
   }
   
}
