/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
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
@WebServlet(name = "lostpet", urlPatterns = {"/lostpet"})
public class lostpet extends HttpServlet {

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
      String Name = request.getParameter("name");
        String Type = request.getParameter("type");
        String LSLoc = request.getParameter("lsloc");
        String Age = request.getParameter("age");
        String Colour = request.getParameter("colour");
        String desc = request.getParameter("des");
        
    Connection conn;
    Statement stat;
    ResultSet rs;
    String sql;
        
        Connections reg = new Connections();
        reg.Connect();
        conn = reg.con;
        stat = reg.qry;
        
        HttpSession session = request.getSession();
        String nic = (String) session.getAttribute("NIC");
        
        try{ 
                sql = "INSERT INTO `lost` (`Name`, `Type`, `Age`, `Colour`, `LSLoc`, `ONIC`, `Lat`,`Lon`,`Dis`,`isFound`) VALUES (?,?,?,?,?,?,?,?,?,?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, Name);
                ps.setString(2, Type);
                ps.setString(3, Age);
                ps.setString(4, Colour);
                ps.setString(5, LSLoc);
                ps.setString(6, nic);
                ps.setString(7, "");
                ps.setString(8, "");
                ps.setString(9, desc);
                ps.setString(10, "0");
                ps.execute();
                conn.close();
            response.sendRedirect(request.getContextPath()+"/lostmy.jsp?Img=True");
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
