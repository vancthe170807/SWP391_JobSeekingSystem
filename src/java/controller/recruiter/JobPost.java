/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.recruiter;

import constant.CommonConst;
import static constant.CommonConst.RECORD_PER_PAGE;
import dao.JobPostingsDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import model.JobPostings;
import model.PageControl;
import validate.Validation;

@WebServlet(name = "JobPost", urlPatterns = {"/jobPost"})
public class JobPost extends HttpServlet {

    JobPostingsDAO dao = new JobPostingsDAO();
    Validation valid = new Validation();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       // Lấy tham số tìm kiếm và phân trang từ request
        String searchJP = request.getParameter("searchJP") != null ? request.getParameter("searchJP") : "";
        String sortField = request.getParameter("sort") != null ? request.getParameter("sort") : "JobPostingID";
        int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int pageSize = 10;  // Số lượng bản ghi trên mỗi trang

        List<JobPostings> jobList;
        int totalRecords;

        // Kiểm tra nếu có từ khóa tìm kiếm
        if (!searchJP.isEmpty()) {
            // Gọi DAO method để tìm kiếm và phân trang
            jobList = dao.searchJobPostingByTitle(searchJP, page);
            totalRecords = dao.findTotalRecordByTitle(searchJP);  // Đếm tổng kết quả tìm kiếm
                if(jobList.isEmpty()){
                    request.setAttribute("NoJP", "No found");
                }
        } else {
            // Nếu không có từ khóa tìm kiếm, lấy tất cả dữ liệu và phân trang
            jobList = dao.findJobPostingsWithFilter(sortField, page, pageSize);
            totalRecords = dao.countTotalJobPostings();  // Đếm tổng số bản ghi
        }

        // Tính toán tổng số trang
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        // Gửi các thông tin cần thiết về JSP
        request.setAttribute("listJobPosting", jobList);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("sortField", sortField);
        request.setAttribute("searchJP", searchJP);  // Để giữ lại từ khóa tìm kiếm khi phân trang

        // Chuyển hướng đến trang quản lý Job Posting
        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/recruiter/jobPost-manager.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url;

        switch (action) {
            case "add-jp":
                url = addJobPosting(request, response);
                break;
            case "listJobPosting":
                url = listJobPosting(request, response);
                break;
            case "updateJobPost":
                url = updateJP(request, response);
                break;
            default:
                url = "view/recruiter/jobPost-manager.jsp";
                break;
        }
        request.getRequestDispatcher(url).forward(request, response);
    }

    private String addJobPosting(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = null;
        try {
            String jobTitle = request.getParameter("jobTitle");
            String jobDescription = request.getParameter("jobDescription");
            String jobRequirements = request.getParameter("jobRequirements");
            String jobLocation = request.getParameter("jobLocation");
            double jobSalary = Double.parseDouble(request.getParameter("jobSalary"));
            String jobStatus = request.getParameter("jobStatus");
            Date postedDate = Date.valueOf(request.getParameter("postedDate"));
            Date closingDate = Date.valueOf(request.getParameter("closingDate"));

            // Set form data back into the request to retain user input
            request.setAttribute("jobTitle", jobTitle);
            request.setAttribute("jobDescription", jobDescription);
            request.setAttribute("jobRequirements", jobRequirements);
            request.setAttribute("jobLocation", jobLocation);
            request.setAttribute("jobSalary", jobSalary);
            request.setAttribute("jobStatus", jobStatus);
            request.setAttribute("postedDate", postedDate);
            request.setAttribute("closingDate", closingDate);

            JobPostings jobPost = new JobPostings();

            jobPost.setTitle(jobTitle);
            jobPost.setDescription(jobDescription);
            jobPost.setRequirements(jobRequirements);
            jobPost.setLocation(jobLocation);
            jobPost.setSalary(jobSalary);
            jobPost.setStatus(jobStatus);
            jobPost.setPostedDate(postedDate);
            jobPost.setClosingDate(closingDate);

            List<String> erMess = new ArrayList<>();
            if (!valid.checkAtLeast30Chars(jobDescription)) {
                erMess.add("Description too short");
            }
            if (!valid.checkAtLeast30Chars(jobRequirements)) {
                erMess.add("Requirements too short");
            }
            if (!valid.isValidDateRange(postedDate) | !valid.isValidDateRange(closingDate)) {
                erMess.add("Date month year must be greater than 1990 and less than 2500");
            }
            if (!valid.isStartDateBeforeEndDate(postedDate, closingDate)) {
                erMess.add("Expiration date must be greater than post date");
            }
            if (!valid.isToday(postedDate)) {
                erMess.add("Post date must be current date");
            }

            if (!erMess.isEmpty()) {
                request.setAttribute("erMess", erMess);
                url = "view/recruiter/addJobPosting.jsp";
            } else {
                dao.insert(jobPost);
                request.setAttribute("successPost", "Posting successful");
                url = "view/recruiter/addJobPosting.jsp";
            }
        } catch (Exception e) {
            e.printStackTrace();
            url = "view/recruiter/addJobPosting.jsp";
        }
        return url;
    }

    private String listJobPosting(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = null;
        List<JobPostings> listJobPosting = dao.findAll();
        HttpSession session = request.getSession();
        session.setAttribute("listJobPosting", listJobPosting);
        url = "view/recruiter/jobPost-manager.jsp";
        return url;
    }

    private String updateJP(HttpServletRequest request, HttpServletResponse response) {
        String url;
        int idJP = Integer.parseInt(request.getParameter("JobPostingID"));

        String jobTitle = request.getParameter("jobTitle");
        String jobDescription = request.getParameter("jobDescription");
        String jobRequirements = request.getParameter("jobRequirements");
        String jobLocation = request.getParameter("jobLocation");
        double jobSalary = Double.parseDouble(request.getParameter("jobSalary"));
        String jobStatus = request.getParameter("jobStatus");
        Date postedDate = Date.valueOf(request.getParameter("postedDate"));
        Date closingDate = Date.valueOf(request.getParameter("closingDate"));

        // Set form data back into the request to retain user input
        request.setAttribute("jobTitle", jobTitle);
        request.setAttribute("jobDescription", jobDescription);
        request.setAttribute("jobRequirements", jobRequirements);
        request.setAttribute("jobLocation", jobLocation);
        request.setAttribute("jobSalary", jobSalary);
        request.setAttribute("jobStatus", jobStatus);
        request.setAttribute("postedDate", postedDate);
        request.setAttribute("closingDate", closingDate);

        JobPostings jobPost = dao.findJobPostingById(idJP);

        //jobPost.setJobPostingID(idJP);
        jobPost.setTitle(jobTitle);
        jobPost.setDescription(jobDescription);
        jobPost.setRequirements(jobRequirements);
        jobPost.setLocation(jobLocation);
        jobPost.setSalary(jobSalary);
        jobPost.setStatus(jobStatus);
        jobPost.setPostedDate(postedDate);
        jobPost.setClosingDate(closingDate);

        List<String> erMess = new ArrayList<>();
        if (!valid.checkAtLeast30Chars(jobDescription)) {
            erMess.add("Description too short");
        }
        if (!valid.checkAtLeast30Chars(jobRequirements)) {
            erMess.add("Requirements too short");
        }
        if (!valid.isValidDateRange(postedDate) | !valid.isValidDateRange(closingDate)) {
            erMess.add("Date month year must be greater than 1990 and less than 2500");
        }
        if (!valid.isStartDateBeforeEndDate(postedDate, closingDate)) {
            erMess.add("Expiration date must be greater than post date");
        }
        if (!valid.isToday(postedDate)) {
            erMess.add("Post date must be current date");
        }

        if (!erMess.isEmpty()) {
            request.setAttribute("eM", erMess);
            url = "view/recruiter/editJP.jsp";
        } else {
            dao.updateJobPosting(jobPost);
            List<JobPostings> listJobPosting = dao.findAll();
            request.setAttribute("listJobPosting", listJobPosting);
            url = "view/recruiter/jobPost-manager.jsp";
        }
        return url;
    }

}
