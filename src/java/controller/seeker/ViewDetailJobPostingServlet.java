/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.seeker;

import constant.CommonConst;
import dao.ApplicationDAO;
import dao.CVDAO;
import dao.FavourJobPostingDAO;
import dao.JobPostingsDAO;
import dao.JobSeekerDAO;
import dao.Job_Posting_CategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.Applications;
import model.CV;
import model.FavourJobPosting;
import model.JobPostings;
import model.JobSeekers;
import model.Job_Posting_Category;
import validate.Validation;

@WebServlet(name = "ViewDetailJobPostingServlet", urlPatterns = {"/jobPostingDetail"})
public class ViewDetailJobPostingServlet extends HttpServlet {

    Job_Posting_CategoryDAO categoryDAO = new Job_Posting_CategoryDAO();
    JobPostingsDAO dao = new JobPostingsDAO();
    JobSeekerDAO jobSeekerDAO = new JobSeekerDAO();
    Validation valid = new Validation();
    ApplicationDAO applicationDAO = new ApplicationDAO();
    FavourJobPostingDAO favourJPDAO = new FavourJobPostingDAO();
    CVDAO cvDAO = new CVDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url;
        switch (action) {
            case "details":
                url = viewJP(request, response);
                break;
            case "add-application": {
                String jobPostingIDStr = request.getParameter("jobPostingID");

                // Log to confirm jobPostingIDStr presence before proceeding
                System.out.println("jobPostingIDStr before addApplication: " + jobPostingIDStr);

                // Redirect to error page if jobPostingID is missing
                if (jobPostingIDStr == null || jobPostingIDStr.isEmpty()) {
                    request.setAttribute("error", "Job posting ID is missing.");
                    url = "errorPage.jsp";
                    break;
                }

                url = addApplication(request, response);
            }
            break;
            case "add-favourJP": {
                String jobPostingIDStr = request.getParameter("jobPostingIDF");

                // Log to confirm jobPostingIDStr presence before proceeding
                System.out.println("jobPostingIDStr before addApplication: " + jobPostingIDStr);

                // Redirect to error page if jobPostingID is missing
                if (jobPostingIDStr == null || jobPostingIDStr.isEmpty()) {
                    request.setAttribute("error", "Job posting ID is missing.");
                    url = "errorPage.jsp";
                    break;
                }

                url = addFavourJP(request, response);
            }
            break;
            default:
                url = "view/user/ViewJobPosting.jsp";
        }
        request.getRequestDispatcher(url).forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url;

        switch (action) {

            case "add-application":
                url = addApplication(request, response);
                break;
            case "add-favourJP":
                url = addFavourJP(request, response);
                break;
            default:
                url = "home"; // Default URL if no action matches
        }

        response.sendRedirect(url);

    }

    private String viewJP(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = null;
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);

        if (account == null) {
            return "home"; // Redirect if the user is not logged in
        } else {
            int idJP = Integer.parseInt(request.getParameter("idJP"));
            JobPostings jobPost = dao.findJobPostingById(idJP);
            request.setAttribute("jobPost", jobPost);
            //lay ve notice
            String notice = request.getParameter("notice");
            request.setAttribute("notice", notice);
            Job_Posting_Category category = categoryDAO.findJob_Posting_CategoryNameByJobPostingID(idJP);
            request.setAttribute("category", category); // Đặt với tên 'category'

            JobSeekers jobSeeker = jobSeekerDAO.findJobSeekerIDByAccountID(String.valueOf(account.getId()));
            if (jobSeeker == null) {
                try {
                    url = "jobPostingDetail?error=" + URLEncoder.encode("You are not currently a member of Job Seeker. Please join to use this function.", "UTF-8");
                } catch (UnsupportedEncodingException ex) {
                    Logger.getLogger(ApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                return url;
            }

            Applications existingApplication = applicationDAO.findPendingApplication(jobSeeker.getJobSeekerID(), jobPost.getJobPostingID());
            if(existingApplication != null) {
                request.setAttribute("existingApplication", existingApplication);
            }
            
            FavourJobPosting existFavourJP = favourJPDAO.findExistFavourJP(jobSeeker.getJobSeekerID(), jobPost.getJobPostingID());
            if(existFavourJP != null) {
                request.setAttribute("existFavourJP", existFavourJP);
            }
            url = "view/user/ViewJobPosting.jsp";
            return url;
        }
    }

    //Tao 1 don xin viec
    public String addApplication(HttpServletRequest request, HttpServletResponse response) {
        String url = "view/authen/login.jsp"; // Default page on error
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);

        if (account == null) {
            return url; // Redirect if not logged in
        }

        JobSeekers jobSeeker = jobSeekerDAO.findJobSeekerIDByAccountID(String.valueOf(account.getId()));
        if (jobSeeker == null) {
            try {
                url = "jobPostingDetail?error=" + URLEncoder.encode("You are not currently a member of Job Seeker. Please join to use this function.", "UTF-8");
            } catch (UnsupportedEncodingException ex) {
                Logger.getLogger(ApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            return url;
        }

        CV cv = cvDAO.findCVbyJobSeekerID(jobSeeker.getJobSeekerID());
        if (cv == null) {
            request.setAttribute("error", "No CV found for the current account.");
            url = "view/user/jobPostingDetail.jsp";
            return url;
        }

        int jobPostingID = Integer.parseInt(request.getParameter("jobPostingID"));
        JobPostings jobPosting = dao.findJobPostingById(jobPostingID);

        // Kiểm tra application đang pending
        Applications existingApplication = applicationDAO.findPendingApplication(jobSeeker.getJobSeekerID(), jobPostingID);

        // Thiết lập các attribute chung
        request.setAttribute("jobPosting", jobPosting);
        request.setAttribute("CV", cv);
        request.setAttribute("jobSeeker", jobSeeker);

        if (existingApplication != null) {
            try {
                url = "jobPostingDetail?error=" + URLEncoder.encode("Bạn đã có một đơn ứng tuyển đang ở trạng thái Pending cho vị trí này!", "UTF-8");
            } catch (UnsupportedEncodingException ex) {
                Logger.getLogger(ViewDetailApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            return url;

        } else {
            // Tạo application mới nếu chưa có application pending
            Applications application = new Applications();
            application.setJobPostingID(jobPostingID);
            application.setJobSeekerID(jobSeeker.getJobSeekerID());
            application.setCVID(cv.getCVID());
            application.setStatus(3); // Set status pending
            applicationDAO.insert(application);

            request.setAttribute("success", "Đơn ứng tuyển đã được gửi thành công.");
            url = "jobPostingDetail?action=details&idJP=" + jobPostingID;
        }

        return url;
    }

    public String addFavourJP(HttpServletRequest request, HttpServletResponse response) {
        String url = "view/authen/login.jsp"; // Default page on error
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);

        // Check if the user is logged in
        if (account == null) {
            return url; // Redirect if not logged in
        }

        // Retrieve job seeker ID by account ID
        JobSeekers jobSeeker = jobSeekerDAO.findJobSeekerIDByAccountID(String.valueOf(account.getId()));
        if (jobSeeker == null) {
            try {
                url = "jobPostingDetail?error=" + URLEncoder.encode("You are not currently a member of Job Seeker. Please join to use this function.", "UTF-8");
            } catch (UnsupportedEncodingException ex) {
                Logger.getLogger(ApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            return url;
        }

        // Get job posting ID from request
        int jobPostingID = Integer.parseInt(request.getParameter("jobPostingIDF"));

        // Fetch the job posting details
        JobPostings jobPosting = dao.findJobPostingById(jobPostingID);
        if (jobPosting == null) {
            request.setAttribute("error", "Job posting not found.");
            return "jobPostingDetail?action=details&idJP=" + jobPostingID; // Redirect to an error page or similar
        }

        request.setAttribute("jobPostingF", jobPosting);
        request.setAttribute("jobSeekerF", jobSeeker);

        // Check if the favorite already exists
        boolean favourJPExist = favourJPDAO.getJobPostingsByJobSeeker(jobSeeker.getJobSeekerID(), jobPostingID);

        if (!favourJPExist) {
            FavourJobPosting favourJobPosting = new FavourJobPosting();
            favourJobPosting.setJobSeekerID(jobSeeker.getJobSeekerID());
            favourJobPosting.setJobPostingID(jobPostingID);

            favourJPDAO.insert(favourJobPosting);

        } else {
            request.setAttribute("info", "You have already saved this job posting.");
        }

        // Redirect to the job posting detail page
        url = "jobPostingDetail?action=details&idJP=" + jobPostingID;
        return url;
    }

}
