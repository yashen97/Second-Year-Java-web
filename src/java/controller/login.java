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
@WebServlet(name = "login", urlPatterns = {"/login"})
public class login extends HttpServlet {

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
        sql = "SELECT Password,type from users WHERE NIC = '"+request.getParameter("nic")+"'";
        String enc = request.getParameter("pwd");
        Encryption aes = new Encryption("Plymouth@England");
        try {
             en = aes.encrypt(enc);
        } catch (Exception ex) {
            Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            rs = stat.executeQuery(sql);
            if(rs.next()){
            String pwd = rs.getString("Password");
            String type = rs.getString("type");
            if(pwd.equals(en)){
                HttpSession session = request.getSession();
                session.setAttribute("NIC", request.getParameter("nic"));
                session.setAttribute("Type", type);
                if(type.equals("user"))
                response.sendRedirect(request.getContextPath() + "/userEvents.jsp");
                else if(type.equals("admin"))
                 response.sendRedirect(request.getContextPath() + "/admin.jsp");   
            }
            else{
                response.sendRedirect(request.getContextPath() + "/login.jsp?Error=true");
                }
            }
            else {
            response.sendRedirect(request.getContextPath() + "/login.jsp?Error=true");
            }
        } catch (SQLException ex) {
            
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
