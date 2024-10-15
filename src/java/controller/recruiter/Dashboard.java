/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.recruiter;

import dao.JobPostingsDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.JobPostings;
import model.WeeklyPostings;

@WebServlet(name = "Dashboard", urlPatterns = {"/Dashboard"})
public class Dashboard extends HttpServlet {
    JobPostingsDAO jobPostingsDAO = new JobPostingsDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JobPostingsDAO dao = new JobPostingsDAO();
        List<JobPostings> listJobPostings = dao.getTop5RecentJobPostings();
        List<JobPostings> listAll = dao.findAll();
        request.setAttribute("listSize", listAll);
        request.setAttribute("listJobPostings", listJobPostings);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/recruiter/dashboard.jsp");
        dispatcher.forward(request, response);
    }

}
