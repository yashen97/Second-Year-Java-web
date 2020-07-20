/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Connections;

/**
 *
 * @author Tharusha Kudagala
 */
@WebServlet(name = "appoint", urlPatterns = {"/appoint"})
public class appoint extends HttpServlet {

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
        
        HttpSession session = request.getSession();
        
      if(session.getAttribute("NIC")!= null){
    String pid = request.getParameter("pid");
            
    Connection conn;
    Statement stat;
    ResultSet rs;
    String sql;
    
Calendar cal = Calendar.getInstance();
SimpleDateFormat dateOnly = new SimpleDateFormat("dd-MM-yyyy");
String date = (String)dateOnly.format(cal.getTime());

        Connections log = new Connections();
        log.Connect();
        conn = log.con;
        stat = log.qry;
        
       sql = " INSERT INTO `appoint` (`AID`, `petID`, `NIC`, `reqDate`, `isDone`) VALUES (NULL, '"+pid+"', '"+session.getAttribute("NIC")+"', '"+date+"','0')";
          try {
              stat.execute(sql);
              
       String sql2 = "UPDATE `shelter` SET `isHere` = '0' WHERE `shelter`.`petID` = '"+pid+"'";       
       stat.executeUpdate(sql2);
        response.sendRedirect(request.getContextPath()+"/userEvents.jsp");
          } catch (SQLException ex) {
              System.out.println("+++++" + ex);
          }
        }
      else{
       response.sendRedirect(request.getContextPath()+"/login.jsp");
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
