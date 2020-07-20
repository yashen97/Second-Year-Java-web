/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Encryption;
import java.sql.*;
import javax.servlet.http.HttpSession;
import model.Connections;

/**
 *
 * @author Tharusha Kudagala
 */
@WebServlet(name = "reset", urlPatterns = {"/reset"})
public class reset extends HttpServlet {

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
       
        String newPass = request.getParameter("cpassword");
        Encryption aes = new Encryption("Plymouth@England");
        HttpSession session = request.getSession();
        String mail = (String) session.getAttribute("mail");
        
    Connection conn;
    Statement stat;
    ResultSet rs;
    String sql;
        
        Connections reset = new Connections();
        reset.Connect();
        conn = reset.con;
        stat = reset.qry;
        
        
        try {
            newPass = aes.encrypt(newPass);
            sql = "Update users set Password='"+newPass+"' WHERE Email='"+mail+"'";
            stat.executeUpdate(sql);
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            session.invalidate();
            
        } catch (Exception ex) {
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
