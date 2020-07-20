/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import java.sql.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpSession;
import model.Connections;
/**
 *
 * @author Tharusha Kudagala
 */
@WebServlet(name = "imageLost", urlPatterns = {"/imageLost"})
public class imageLost extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
           
    Connection conn;
    Statement stat;
    ResultSet rs;
    String sql;
        
        Connections reg = new Connections();
        reg.Connect();
        conn = reg.con;
        stat = reg.qry;
        
        //Image Upload
        //Image upload and save
        File file ;
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 5000 * 1024;
   String filePath = "D:\\iPET\\web\\public\\data\\lost\\";
 
   String contentType = request.getContentType();
   if ((contentType.indexOf("multipart/form-data") >= 0)) {
 
      DiskFileItemFactory factory = new DiskFileItemFactory();
      factory.setSizeThreshold(maxMemSize);
      factory.setRepository(new File("c:\\temp"));
      ServletFileUpload upload = new ServletFileUpload(factory);
      upload.setSizeMax( maxFileSize );
      try{ 
         List fileItems = upload.parseRequest(request);
         Iterator i = fileItems.iterator();
         
         long unixTime = System.currentTimeMillis() / 1000L;
         while ( i.hasNext () ) 
         {
            FileItem fi = (FileItem)i.next();
            if ( !fi.isFormField () )  {
                String fieldName = fi.getFieldName();
                String fileName = fi.getName();
                boolean isInMemory = fi.isInMemory();
                long sizeInBytes = fi.getSize();
                
                file = new File( filePath +"lost~"+unixTime+".png" ) ;
                fi.write( file ) ;
                String filename = file.getName();
                System.out.println("File name " + filename);
                
                sql = "SELECT LID FROM lost ORDER BY LID DESC LIMIT 1";
                rs = stat.executeQuery(sql);
                int LID = 0;
                if(rs.next()){
                   LID = rs.getInt("LID");
                }
                System.out.println("Last" + LID);
                HttpSession session = request.getSession();
                session.setAttribute("LID", LID);
                
              String sql2 = "UPDATE lost SET Thumbnail = '"+filename+"' WHERE LID = '"+LID+"'";
              stat.executeUpdate(sql2);
                conn.close();
                response.sendRedirect(request.getContextPath()+"/maplost.jsp");
            }
           
         }
       
      }catch(Exception ex) {
         System.out.println(ex);
      }
   }
  
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
