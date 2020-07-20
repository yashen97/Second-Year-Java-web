/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.design.JRDesignQuery;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.jasperreports.view.JasperViewer;
import java.util.concurrent.TimeUnit;
import model.Connections;
import model.emailsending;
import net.sf.jasperreports.engine.JRException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.Connections;

/**
 *
 * @author Tharusha Kudagala
 */
@WebServlet(name = "genreport", urlPatterns = {"/genreport"})
@MultipartConfig(maxFileSize = 16177215)	// upload file's size up to 16MB
public class genreport extends HttpServlet {

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
        
        String Pname = "", Ptype = "", Pgender = "", Page = "", Colour = "", Des = "", Thumb = "" ;
        String UNAME = "", NIC = "", GENDER = "", DOB = "", Email = "", City = "", District = "", profile = "", address = "" ;
               
        String AID = request.getParameter("AID");
        String CName = request.getParameter("CName");
        Pname = request.getParameter("PName");
        address = request.getParameter("Address");
        City = request.getParameter("City");
        District = request.getParameter("District");
        Pname = request.getParameter("PName");
        Ptype = request.getParameter("Type");
        Pgender = request.getParameter("Gender");
        Page = request.getParameter("Age");
        Colour = request.getParameter("Colour");
        Des = request.getParameter("Des");
        Email = request.getParameter("email");
        Thumb = request.getParameter("Thumb");
        
        try {
		
			// constructs SQL statement
			sql = "UPDATE `report` SET AID = '"+AID+"', CName = '"+CName+"', Address='"+address+"', City='"+City+"', District='"+District+"', PName ='"+Pname+"', Type = '"+Ptype+"', Gender = '"+Pgender+"', Age = '"+Page+"', Colour = '"+Colour+"', Decs = '"+Des+"' WHERE `report`.`x` = 1";
			stat.executeUpdate(sql);
                        
                        Connection con = null;
        PreparedStatement pst = null;
        String sqll = "";
        JasperDesign jd;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ipet","root","");
            jd = JRXmlLoader.load("D:\\iPET\\src\\java\\report\\report.jrxml");
             sqll = "select * from report";
            JRDesignQuery upqry = new JRDesignQuery();
            upqry.setText(sqll);
            
            jd.setQuery(upqry);
            JasperReport jreport = JasperCompileManager.compileReport(jd);
            JasperPrint jprint=JasperFillManager.fillReport(jreport, null, con);
            JasperExportManager.exportReportToPdfFile(jprint,"D:\\iPET\\src\\java\\report\\report.pdf" );
           
        } catch (Exception ex) {
            System.out.println("Exception " + ex );
        }
      String emaill = Email;
      String nam = UNAME;
        //sending email
             emailsending e = new emailsending();
        try {   
            e.send2(emaill,nam);
            response.sendRedirect(request.getContextPath()+ "/admin.jsp");
        } catch (Exception ex) {
            System.out.println("Error " + ex);
        }      
		} catch (SQLException ex) {
			ex.printStackTrace();
		
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
