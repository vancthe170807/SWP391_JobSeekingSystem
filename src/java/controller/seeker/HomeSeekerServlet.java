/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.seeker;

import dao.CompanyDAO;
import dao.JobPostingsDAO;
import dao.Job_Posting_CategoryDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Company;
import model.JobPostings;
import model.Job_Posting_Category;

@WebServlet(name = "HomeSeekerServlet", urlPatterns = {"/HomeSeeker"})
public class HomeSeekerServlet extends HttpServlet {

    private final JobPostingsDAO jobPostingsDAO = new JobPostingsDAO();
    private final CompanyDAO companyDAO = new CompanyDAO();
    private final Job_Posting_CategoryDAO jobCategoryDAO = new Job_Posting_CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String filter = request.getParameter("filter");
        
        List<JobPostings> listTop6;
        if (filter == null || filter.isEmpty()) {
            // Nếu không có filter, lấy top 6 công việc gần đây
            listTop6 = jobPostingsDAO.getTop6RecentJobPostingsByOpen();
        } else {
            // Lấy danh sách công việc theo category ID từ filter
            int categoryId = Integer.parseInt(filter);
            listTop6 = jobPostingsDAO.getTop6JobPostingsByCategory(categoryId);
        }
        
        List<Job_Posting_Category> jobCategories = jobCategoryDAO.findAll();
        List<Company> listTop3Company = companyDAO.getTop3RecentCompanysByOpen();

        request.setAttribute("listTop6", listTop6);
        request.setAttribute("listTop3Company", listTop3Company);
        request.setAttribute("jobCategories", jobCategories);
        request.setAttribute("selectedFilter", filter); 

        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/user/userHome.jsp");
        dispatcher.forward(request, response);
    }

}
