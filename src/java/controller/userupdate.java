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
/**
 *
 * @author Tharusha Kudagala
 */
@WebServlet(name = "userupdate", urlPatterns = {"/userupdate"})
public class userupdate extends HttpServlet {

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
       
        Connection con;
        ResultSet rs;
        Statement stat;
        String sql;
        
        Connections reg = new Connections();
        reg.Connect();
        con = reg.con;
        stat = reg.qry;
        HttpSession session = request.getSession();
        String nic = (String) session.getAttribute("NIC");
        
        String newnic = request.getParameter("newnic");
        String Name = request.getParameter("name");
        String DOB = request.getParameter("DOB");
        String mail = request.getParameter("email");
        String Address = request.getParameter("address");
        String City = request.getParameter("city");
        String District = request.getParameter("district");
        
        sql = "UPDATE `users` SET `NIC` = '"+newnic+"', `Name` = '"+Name+"', `DOB` = '"+DOB+"', `Email` = '"+mail+"', `Address` = '"+Address+"', `City` = '"+City+"', `District` = '"+District+"' WHERE `users`.`NIC` = '"+nic+"'";
        try {
            stat.executeUpdate(sql);
            response.sendRedirect(request.getContextPath()+"/userProfile.jsp");
            session.setAttribute("NIC", newnic);
        } catch (SQLException ex) {
            response.sendError(0, "NIC Already exists");
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
