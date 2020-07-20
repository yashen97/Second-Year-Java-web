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
import model.Encryption;
/**
 *
 * @author Tharusha Kudagala
 */
@WebServlet(name = "userdataupdate", urlPatterns = {"/userdataupdate"})
public class userdataupdate extends HttpServlet {

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
        Connection con;
        ResultSet rs;
        Statement stat;
        String sql;
        
        Connections reg = new Connections();
        reg.Connect();
        con = reg.con;
        stat = reg.qry;
          Encryption enc = new Encryption("Plymouth@England");
        HttpSession session = request.getSession();
        String nic = (String) session.getAttribute("NIC");
        
        
        String current = request.getParameter("current");
        String pwd = request.getParameter("cpwd");
        
        sql = "SELECT Password from users WHERE NIC = '"+nic+"'";
        try {
            rs = stat.executeQuery(sql);
            if(rs.next()){
               if(rs.getString("Password").equals(enc.encrypt(current))){
                   String newPwd = enc.encrypt(pwd);
                   sql = "UPDATE `users` SET `Password` = '"+newPwd+"' WHERE `users`.`NIC` = '"+nic+"'";
                   stat.executeUpdate(sql);
                   response.sendRedirect(request.getContextPath()+"/login.jsp");
               }
               else{
               response.sendRedirect(request.getContextPath()+"/userProfile.jsp");
               }
            }
            else{
            response.sendRedirect(request.getContextPath()+"/userProfile.jsp");
            }
        }  catch (Exception ex) {
            System.out.println("Error : " + ex);
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
