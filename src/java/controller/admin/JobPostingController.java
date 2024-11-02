/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import static constant.CommonConst.RECORD_PER_PAGE;
import dao.AccountDAO;
import dao.JobPostingsDAO;
import dao.RecruitersDAO;
import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.JobPostings;
import model.PageControl;
import model.Recruiters;
import utils.Email;

@WebServlet(name = "JobPostingController", urlPatterns = {"/job_posting"})
public class JobPostingController extends HttpServlet {

    JobPostingsDAO jobPostingsDAO = new JobPostingsDAO();
    RecruitersDAO reDao = new RecruitersDAO();
    AccountDAO accDao = new AccountDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //get ve thong báo
        String success = request.getParameter("success") != null ? request.getParameter("success") : "";
        String error = request.getParameter("error") != null ? request.getParameter("error") : "";
        request.setAttribute("success", success);
        request.setAttribute("error", error);
        // get ve pageNumber
        PageControl pageControl = new PageControl();
        String pageRaw = request.getParameter("page");
        //valid page
        int page;
        try {
            page = Integer.parseInt(pageRaw);
            if (page <= 1) {
                page = 1;
            }
        } catch (NumberFormatException e) {
            page = 1;
        }
        //get ve url
        String requestURL = request.getRequestURL().toString();
        //get ve ben jsp
        String status = request.getParameter("filterStatus") != null ? request.getParameter("filterStatus") : "";
        String salaryRange = request.getParameter("filterSalary") != null ? request.getParameter("filterSalary") : "";
        String postDate = request.getParameter("filterDate") != null ? request.getParameter("filterDate") : "";

        String search = request.getParameter("search") != null ? request.getParameter("search") : "";

        List<JobPostings> jobPostingsList = jobPostingsDAO.findAndfilterJobPostings(status, salaryRange, postDate, search, page);
        int totalRecord = jobPostingsDAO.findAndfilterAllRecord(status, salaryRange, postDate, search);
        
        pageControl.setUrlPattern(requestURL + "?filterStatus=" + status + "&filterSalary=" 
                + salaryRange + "&search=" + search  + "&");
        request.setAttribute("jobPostingsList", jobPostingsList);
        //total page
        int totalPage = (totalRecord % RECORD_PER_PAGE) == 0 ? (totalRecord / RECORD_PER_PAGE) : (totalRecord / RECORD_PER_PAGE) + 1;
        //set total record, total page, page to pageControl
        pageControl.setPage(page);
        pageControl.setTotalRecord(totalRecord);
        pageControl.setTotalPages(totalPage);
        //set attribute pageControl 
        request.setAttribute("pageControl", pageControl);
        request.getRequestDispatcher("view/admin/jobPostManagement.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "";
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        switch (action) {
            case "violate":
                url = violateJobPosting(request);
                break;
            case "view":
                url = viewJobPosting(request);
                request.getRequestDispatcher(url).forward(request, response);
                return;
            default:
                url = "job_posting";
        }
        response.sendRedirect(url);
    }

    private String violateJobPosting(HttpServletRequest request) throws UnsupportedEncodingException {
        String url = "";
        try {
            int jobPostId = Integer.parseInt(request.getParameter("jobPostID"));
            //lay ve account mail
            JobPostings jobPost = jobPostingsDAO.findJobPostingById(jobPostId);
            int recruiterId = jobPost.getRecruiterID();
            Recruiters recruiters = reDao.findById(String.valueOf(recruiterId));
            Account account = accDao.findUserById(recruiters.getAccountID());
            String subject = "Job Posting Suspension Notice";
            String content = request.getParameter("response");
            Email.sendEmail(account.getEmail(), subject, content);
            jobPostingsDAO.violateJobPost(jobPostId);
            url = "job_posting?success=" + URLEncoder.encode("Violate job post and send email successfully!!", "UTF-8");
        } catch (MessagingException ex) {
            url = "job_posting?error=" + URLEncoder.encode("Have error in process violate job post and send email!!", "UTF-8");
        }
        return url;
    }

    private String viewJobPosting(HttpServletRequest request) {
        int jobPostId = Integer.parseInt(request.getParameter("jobPostID"));
        JobPostings jobPost = jobPostingsDAO.findJobPostingById(jobPostId);
        request.setAttribute("jobPost", jobPost);
        return "view/admin/detailJobPosting.jsp";
    }

}
