/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import model.Connections;
/**
 *
 * @author Tharusha Kudagala
 */

@WebServlet(name = "createEvent", urlPatterns = {"/createEvent"})
public class createEvent extends HttpServlet {

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
        
        String Title = request.getParameter("title");
        String Date = request.getParameter("date");
        String Time = request.getParameter("time");
        String Place = request.getParameter("place");
        String Type = request.getParameter("type");
        String Descr = request.getParameter("desc");
     
      try{ 
                sql = "INSERT INTO events (Title,Date,Time,Place,Type,Descr,Thumbnail,Lat,Lon) VALUES (?,?,?,?,?,?,?,?,?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, Title);
                ps.setString(2, Date);
                ps.setString(3, Time);
                ps.setString(4, Place);
                ps.setString(5, Type);
                ps.setString(6, Descr);
                ps.setString(7, "");
                ps.setString(8, "no");
                ps.setString(9, "no");
                ps.execute();
                conn.close();
            response.sendRedirect(request.getContextPath()+"/addEvent.jsp?Img=True");
      }catch(Exception ex) {
         System.out.println(ex);
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
