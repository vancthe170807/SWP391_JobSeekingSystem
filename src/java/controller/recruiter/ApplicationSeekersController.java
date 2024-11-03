/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.recruiter;

import dao.AccountDAO;
import dao.ApplicationDAO;
import dao.CVDAO;
import dao.EducationDAO;
import dao.WorkExperienceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Account;
import model.Applications;
import model.CV;
import model.Education;
import model.WorkExperience;
import utils.Email;

/**
 *
 * @author HP
 */
@WebServlet(name = "ApplicationSeekersController", urlPatterns = {"/applicationSeekers"})
public class ApplicationSeekersController extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ApplicationSeekersController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ApplicationSeekersController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        String action = request.getParameter("action");
        action = action != null ? action : "";
        switch (action) {
            case "reject":

                break;
            case "accept":

                break;
            case "viewProfile":
                this.viewProfile(request, response);
                break;
            case "viewCV":
                this.viewCV(request, response);
                break;
            case "viewEducation":
                this.viewEducation(request, response);
                break;
            case "viewWorkExperience":
                this.viewWorkExperience(request, response);
                break;
            default:
                this.getApplicationByJobPost(request, response);
        }
    }

    private void viewWorkExperience(HttpServletRequest request, HttpServletResponse response) {
        try {
            WorkExperienceDAO workDao = new WorkExperienceDAO();
            String accountId = request.getParameter("id");
            List<WorkExperience> workExperience = workDao.findWorkExperiencesbyJobSeekerID(Integer.parseInt(accountId));
            request.setAttribute("WorkExperience", workExperience);
            request.getRequestDispatcher("view/recruiter/workExperienceSeeker.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
    }

    private void viewEducation(HttpServletRequest request, HttpServletResponse response) {
        try {
            EducationDAO eduDao = new EducationDAO();
            String accountId = request.getParameter("id");
            List<Education> educations = eduDao.findEducationbyJobSeekerID(Integer.parseInt(accountId));
            request.setAttribute("educations", educations);
            request.getRequestDispatcher("view/recruiter/educationSeeker.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
    }

    private void viewCV(HttpServletRequest request, HttpServletResponse response) {
        try {
            CVDAO cvDao = new CVDAO();
            String accountId = request.getParameter("id");
            CV cv = cvDao.findCVbyJobSeekerID(Integer.parseInt(accountId));
            String cvPath[] = cv.getFilePath().split("/");
            String cvPathHandle = "./" + cvPath[2] + "/" + cvPath[3];
            String filePath = cvPathHandle;
            cv.setFilePath(filePath);
            request.setAttribute("cv", cv);
            request.getRequestDispatcher("view/recruiter/cvSeeker.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
    }

    private void viewProfile(HttpServletRequest request, HttpServletResponse response) {
        try {
            AccountDAO accountDao = new AccountDAO();
            String accountId = request.getParameter("id");
            Account account = accountDao.findUserById(Integer.parseInt(accountId));
            request.setAttribute("account", account);
            request.getRequestDispatcher("view/recruiter/accountSeeker.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
    }

    private void getApplicationByJobPost(HttpServletRequest request, HttpServletResponse response) {
        try {
            ApplicationDAO applicationDao = new ApplicationDAO();
            String jobPostId = request.getParameter("jobPostId");
            List<Applications> applications = applicationDao.findApplicationByJobPostingID(Integer.parseInt(jobPostId));
            //List<Applications> listStatusJP = applicationDao.getApplicationsWithJobPostingStatus();
            
            request.setAttribute("applications", applications);
            //request.setAttribute("listStatusJP", listStatusJP);
            request.getRequestDispatcher("view/recruiter/manageApplications.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
    }
//    private void getApplicationByJobPost(HttpServletRequest request, HttpServletResponse response) {
//        try {
//            ApplicationDAO applicationDao = new ApplicationDAO();
//            String jobPostId = request.getParameter("jobPostId");
//
//            // Pagination parameters
//            int page = 1; // Default page number
//            int pageSize = 10; // Number of items per page
//
//            // Get the current page from the request, if provided
//            if (request.getParameter("page") != null) {
//                page = Integer.parseInt(request.getParameter("page"));
//            }
//
//            // Calculate the offset (starting point for the database query)
//            int offset = (page - 1) * pageSize;
//
//            // Retrieve paginated applications and the total count
//            List<Applications> applications = applicationDao.findApplicationsByJobPostingIDWithPagination(
//                    Integer.parseInt(jobPostId), offset, pageSize);
//            int totalRecords = applicationDao.countApplicationsByJobPostingID(Integer.parseInt(jobPostId));
//
//            // Calculate total pages
//            int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
//
//            // Set attributes for JSP
//            request.setAttribute("applications", applications);
//            request.setAttribute("currentPage", page);
//            request.setAttribute("totalPages", totalPages);
//
//            // Forward to the JSP
//            request.getRequestDispatcher("view/recruiter/manageApplications.jsp").forward(request, response);
//        } catch (Exception e) {
//            System.out.println("Error: " + e);
//        }
//    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ApplicationDAO applicationDao = new ApplicationDAO();
        try {
            int applicationId = Integer.parseInt(request.getParameter("applicationId"));
            int status = Integer.parseInt(request.getParameter("status"));
            String emailContent = request.getParameter("emailContent");

            applicationDao.ChangeStatusApplication(applicationId, status);
            Applications application = applicationDao.getDetailApplication(applicationId);
            String applicantEmail = application.getJobSeeker().getAccount().getEmail();
            Email email = new Email();
            if (applicantEmail != null && !applicantEmail.isEmpty()) {
                try {
                    email.sendEmail(applicantEmail, "Application Status Update", emailContent);
                    System.out.println("Email đã được gửi đến " + applicantEmail);
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect(request.getContextPath() + "/applicationSeekers?error=emailFailed&jobPostId=" + application.getJobPostingID());
                    return;
                }
            }

            response.sendRedirect(request.getContextPath() + "/applicationSeekers?success=true&jobPostId=" + application.getJobPostingID());

        } catch (Exception e) {
            applicationDao.ChangeStatusApplication(Integer.parseInt(request.getParameter("applicationId")), 3);
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
