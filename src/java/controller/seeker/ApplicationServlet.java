/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.seeker;

import constant.CommonConst;
import dao.ApplicationDAO;
import dao.CVDAO;
import dao.JobPostingsDAO;
import dao.JobSeekerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.Applications;
import model.CV;
import model.JobPostings;
import model.JobSeekers;

@WebServlet(name = "ApplicationServlet", urlPatterns = {"/application"})
public class ApplicationServlet extends HttpServlet {

    private final ApplicationDAO applicationDAO = new ApplicationDAO();
    private final JobSeekerDAO jobSeekerDAO = new JobSeekerDAO();
    private final JobPostingsDAO jobPostingDAO = new JobPostingsDAO();
    private final CVDAO cvDAO = new CVDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    public String viewListApplication(HttpServletRequest request, HttpServletResponse response) {
        String url;
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);

        if (account == null) {
            url = "view/authen/login.jsp"; // Redirect if user is not logged in
        }

        JobSeekers jobSeeker = jobSeekerDAO.findJobSeekerIDByAccountID(String.valueOf(account.getId()));

        if (jobSeeker == null) {
            request.setAttribute("error", "No Job Seeker found for the current account.");
            url = "view/authen/login.jsp"; // Redirect to login page
        }

        List<Applications> applicationList = applicationDAO.findApplicationByJobSeekerID(jobSeeker.getJobSeekerID());

        if (applicationList == null || applicationList.isEmpty()) {
            request.setAttribute("errorApplication", "No Application found for this Job Seeker.");
            url = "view/user/Application.jsp";
        }

        request.setAttribute("applications", applicationList);

        url = "view/user/Application.jsp";

        return url;
    }
    
    //Tao 1 don xin viec
    public String addApplication(HttpServletRequest request, HttpServletResponse response) {
        String url = null;
        
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);

        if (account == null) {
            url = "view/authen/login.jsp"; // Redirect if user is not logged in
        }

        JobSeekers jobSeeker = jobSeekerDAO.findJobSeekerIDByAccountID(String.valueOf(account.getId()));

        if (jobSeeker == null) {
            request.setAttribute("error", "No Job Seeker found for the current account.");
            url = "view/authen/login.jsp"; // Redirect to login page
        }
        
        CV cv = cvDAO.findCVbyJobSeekerID(jobSeeker.getJobSeekerID());
        if(cv == null) {
            request.setAttribute("error", "No CV found for the current account.");
            url = "";
        }
        
        String jobPostingIDStr = request.getParameter("jobPostingID");
        String seekerName = request.getParameter("seekerName");
        
        int jobPostingID = Integer.parseInt(jobPostingIDStr);
        
        JobPostings jobPosting = jobPostingDAO.findJobPostingById(jobPostingID);
        
        Applications application = new Applications();
        application.setJobPostingID(jobPostingID);
        application.setJobSeekerID(jobSeeker.getJobSeekerID());
        application.setCVID(cv.getCVID());
        application.setStatus("");
        
        
        
        
        return url;
    }

}
