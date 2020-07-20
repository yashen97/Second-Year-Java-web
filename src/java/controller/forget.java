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
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import model.Connections;
import model.SimpleMail;
/**
 *
 * @author Tharusha Kudagala
 */
@WebServlet(name = "forget", urlPatterns = {"/forget"})
public class forget extends HttpServlet {

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
            response.setContentType("text/html;charset=UTF-8");
            
    Connection conn;
    Statement stat;
    ResultSet rs;
    String sql;
        
        Connections log = new Connections();
        log.Connect();
        conn = log.con;
        stat = log.qry;
        String en = "";
        sql = "SELECT Name,Email from users WHERE NIC = '"+request.getParameter("nic")+"'";
        
        try {
            rs = stat.executeQuery(sql);
             if(rs.next()){
             String Name = rs.getString("Name");
             String Email = rs.getString("Email");
             
             //Generate Random
             int min = 123456; int max = 987654;
             int random = (int)(Math.random() * (max - min + 1) + min);
             
              HttpSession session=request.getSession();  
              session.setAttribute("otp",random);  
              session.setAttribute("mail",Email);
             
             String msg = "Dear " + Name + ", Your one-time passcode is '" + random + "'";
             
             SimpleMail mail = new SimpleMail();
             mail.sendmail(Email, msg);
             
             //Redirect to verify
             response.sendRedirect(request.getContextPath() + "/verify.jsp");
             }
             else{
                 response.sendRedirect(request.getContextPath() + "/forget.jsp");
             }
        } catch (SQLException ex) {
            Logger.getLogger(forget.class.getName()).log(Level.SEVERE, null, ex);
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
