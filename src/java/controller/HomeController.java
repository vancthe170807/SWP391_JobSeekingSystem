/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.CompanyDAO;
import dao.JobPostingsDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import model.Company;
import model.JobPostings;

@WebServlet(name="HomeController", urlPatterns={"/home"})

public class HomeController extends HttpServlet {
    
    private final JobPostingsDAO jobPostingsDAO = new JobPostingsDAO();
    private final CompanyDAO companyDAO = new CompanyDAO();
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        List<JobPostings> listTop6 = jobPostingsDAO.getTop6RecentJobPostingsByOpen();
        List<Company> listTop3Company = companyDAO.getTop3RecentCompanysByOpen();
        request.setAttribute("listTop6", listTop6);
        request.setAttribute("listTop3Company", listTop3Company);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/home.jsp");
        dispatcher.forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    }
   
    
}