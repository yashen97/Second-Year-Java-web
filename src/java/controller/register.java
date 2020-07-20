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
import model.Connections;
import model.Encryption;

/**
 *
 * @author Tharusha Kudagala
 */
@WebServlet(name = "register", urlPatterns = {"/register"})
public class register extends HttpServlet {

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
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        
    Connection conn;
    Statement stat;
    ResultSet rs;
    String sql;
        
        Connections reg = new Connections();
        reg.Connect();
        conn = reg.con;
        stat = reg.qry;
        
        //Get Form data
        String NIC = request.getParameter("nic");
        String Name = request.getParameter("fname") + " " + request.getParameter("lname");
        String Gender = request.getParameter("sex");
        String DOB = request.getParameter("dob");
        String Email = request.getParameter("email");
        String Address = request.getParameter("address");
        String City = request.getParameter("city");
        String District = request.getParameter("district");
        String Password = request.getParameter("password");
        String profile = "";
        String type = "user";
        if(Gender.contains("F")||Gender.contains("f")){
            profile = "female.jpg";
        }
        else{
            profile = "male.jpg";
        }
        String cover = "default.jpg";
        
        //Encrypt Password
        Encryption aes = new Encryption("Plymouth@England");
       Password =  aes.encrypt(Password);
        
        try{
        sql = "INSERT INTO users (NIC,Name,Gender,DOB,Email,Address,City,District,Password,profile,cover,type) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, NIC);
        ps.setString(2, Name);
        ps.setString(3, Gender);
        ps.setString(4, DOB);
        ps.setString(5, Email);
        ps.setString(6, Address);
        ps.setString(7, City);
        ps.setString(8, District);
        ps.setString(9, Password);
        ps.setString(10, profile);
        ps.setString(11, cover);
        ps.setString(12, type);
        ps.execute();
        conn.close();
        response.sendRedirect(request.getContextPath()+"/login.jsp");
        }
        catch(Exception x){
            System.out.println("Error :- " + x);
            response.sendRedirect(request.getContextPath() + "/register.jsp?Nic="+NIC);
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
        }
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
