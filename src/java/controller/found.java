/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Connections;
import model.SimpleMail;

/**
 *
 * @author Tharusha Kudagala
 */
@WebServlet(name = "found", urlPatterns = {"/found"})
public class found extends HttpServlet {

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
       String lid = request.getParameter("lid");
       String nic = request.getParameter("nic");
       String onic = request.getParameter("onic");
       String pname = request.getParameter("pname");
       
    Connection conn;
    Statement stat;
    ResultSet rs,rs2;
    String sql,sql2,sql3;
        
        Connections reg = new Connections();
        reg.Connect();
        conn = reg.con;
        stat = reg.qry;
        
        sql = "UPDATE lost set FNIC='"+nic+"', isFound = 1 WHERE LID = '"+lid+"'";
        try {
            stat.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(found.class.getName()).log(Level.SEVERE, null, ex);
        }
        sql3 = "SELECT Name, Email, City from users where NIC = '"+nic+"' ";
        String FName = "", FEmail = "" , FCity = "";
        String OName = "", OEmail = "" , OCity = "";
        try {
            rs = stat.executeQuery(sql3);
            if(rs.next()){
                FName = rs.getString("Name");
                FEmail = rs.getString("Email");
                FCity = rs.getString("City");
            }
        } catch (Exception ex) {
            
            Logger.getLogger(found.class.getName()).log(Level.SEVERE, null, ex);
        }
        sql2 = "SELECT Name, Email, City from users where NIC = '"+onic+"' ";
         
        try {
             rs2 = stat.executeQuery(sql2);
            if(rs2.next()){
                OName = rs2.getString("Name");
                OEmail = rs2.getString("Email");
            }   
            
            String msg = "Dear " + OName + ",your lost pet " +pname+ " was found by our member " + FName + " from" + FCity + ".\nYou can connect via Email " + FEmail + " !";
             
             SimpleMail mail = new SimpleMail();
             mail.sendmail(OEmail, msg);
             response.sendRedirect(request.getContextPath() + "/userEvents.jsp");
        
        } catch (SQLException ex) {
            Logger.getLogger(found.class.getName()).log(Level.SEVERE, null, ex);
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
