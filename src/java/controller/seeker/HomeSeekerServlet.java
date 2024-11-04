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
import java.util.ArrayList;
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
        String searchJP = request.getParameter("searchJP") != null ? request.getParameter("searchJP") : "";
        String sortField = request.getParameter("sort") != null ? request.getParameter("sort") : "JobPostingID";
        int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int pageSize = 12; // Number of records per page

        String minSalaryParam = request.getParameter("minSalary");
        String maxSalaryParam = request.getParameter("maxSalary");

        List<JobPostings> listTop6;
        int totalRecords;

        // Determine if salary range filtering is requested
        boolean salaryRangeFilter = (minSalaryParam != null && !minSalaryParam.isEmpty())
                && (maxSalaryParam != null && !maxSalaryParam.isEmpty());

        double minSalary = salaryRangeFilter ? Double.parseDouble(minSalaryParam) : 0;
        double maxSalary = salaryRangeFilter ? Double.parseDouble(maxSalaryParam) : Double.MAX_VALUE;

        // Apply search, filtering, and sorting logic
        if (!searchJP.isEmpty()) {
            // Search job postings by title
            listTop6 = jobPostingsDAO.searchJobPostingByTitle(searchJP, page);
            totalRecords = jobPostingsDAO.findTotalRecordByTitle(searchJP, minSalary, maxSalary);

            if (listTop6.isEmpty()) {
                request.setAttribute("NoJP", "No job postings found.");
            }
        } else if (filter != null && !filter.isEmpty()) {
            // Filter job postings by category
            int categoryId = Integer.parseInt(filter);
            listTop6 = jobPostingsDAO.getJobPostingsByCategory(categoryId);
            totalRecords = jobPostingsDAO.countJobPostingsByCategory(categoryId);
        } else if (salaryRangeFilter) {
            // Filter by salary range only
            listTop6 = jobPostingsDAO.getJobsBySalaryRange(minSalary, maxSalary, page, pageSize, sortField);
            totalRecords = jobPostingsDAO.countJobsBySalaryRange(minSalary, maxSalary);
        } else {
            // Default case: retrieve all job postings
            listTop6 = jobPostingsDAO.findJobPostingsWithFilter(sortField, page, pageSize);
            totalRecords = jobPostingsDAO.countTotalJobPostings();
        }

        // Calculate total pages for pagination
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        List<Job_Posting_Category> jobCategories = jobCategoryDAO.findAll();
        List<Job_Posting_Category> activeCategories = new ArrayList<>();

        for(Job_Posting_Category category: jobCategories) {
            if(category.isStatus()) {
                activeCategories.add(category);
            }
        }

        request.setAttribute("listTop6", listTop6);
        request.setAttribute("activeCategories", activeCategories);
        request.setAttribute("selectedFilter", filter);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("minSalary", minSalaryParam);
        request.setAttribute("maxSalary", maxSalaryParam);
        request.setAttribute("sortField", sortField);
        request.setAttribute("searchJP", searchJP);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/user/userHome.jsp");
        dispatcher.forward(request, response);
    }

}
