package controller.recruiter;

import constant.CommonConst;
import dao.JobPostingsDAO;
import dao.Job_Posting_CategoryDAO;
import dao.RecruitersDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.JobPostings;
import model.Job_Posting_Category;
import model.Recruiters;
import validate.Validation;

@WebServlet(name = "JobPost", urlPatterns = {"/jobPost"})
public class JobPost extends HttpServlet {

    JobPostingsDAO dao = new JobPostingsDAO();
    RecruitersDAO recruitersDAO = new RecruitersDAO();
    Validation valid = new Validation();
    Job_Posting_CategoryDAO category = new Job_Posting_CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);

        if (account == null) {
            // If user is not logged in, redirect to login
            response.sendRedirect("view/authen/login.jsp");
            return;
        }

        // Fetch the recruiter info using the account ID
        Recruiters recruiters = recruitersDAO.findRecruitersbyAccountID(String.valueOf(account.getId()));

        if (recruiters == null || !recruiters.isIsVerify()) {
            request.getRequestDispatcher("view/recruiter/verifyRecruiter.jsp").forward(request, response);
        } else {
            // Lấy tham số tìm kiếm và phân trang từ request
            String searchJP = request.getParameter("searchJP") != null ? request.getParameter("searchJP") : "";
            String sortField = request.getParameter("sort") != null ? request.getParameter("sort") : "JobPostingID";
            int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
            int pageSize = 10;  // Số lượng bản ghi trên mỗi trang

            List<JobPostings> jobList;
            int totalRecords;

            jobList = dao.findJobPostingbyRecruitersID(recruiters.getRecruiterID());

            // Kiểm tra nếu có từ khóa tìm kiếm
            if (!searchJP.isEmpty()) {
                // Gọi DAO method để tìm kiếm và phân trang
                jobList = dao.searchJobPostingByTitleAndRecruiterID(searchJP, recruiters.getRecruiterID(), page);
                totalRecords = dao.findTotalRecordByTitleAndRecruiterID(searchJP, recruiters.getRecruiterID());  // Đếm tổng kết quả tìm kiếm
                if (jobList.isEmpty()) {
                    request.setAttribute("NoJP", "No found");
                }
            } else {
                // Nếu không có từ khóa tìm kiếm, lấy tất cả dữ liệu và phân trang
                jobList = dao.findJobPostingsWithFilterAndRecruiterID(sortField, recruiters.getRecruiterID(), page, pageSize);
                totalRecords = dao.countTotalJobPostingsByRecruiterID(recruiters.getRecruiterID());  // Đếm tổng số bản ghi
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
//            case "updateJobPost":
//                url = updateJP(request, response);
//                break;
            default:
                url = "view/recruiter/jobPost-manager.jsp";
                break;
        }
        request.getRequestDispatcher(url).forward(request, response);
    }

    private String addJobPosting(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = null;
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);

        if (account == null) {
            return "view/authen/login.jsp";
        }

        Recruiters recruiters = recruitersDAO.findRecruitersbyAccountID(String.valueOf(account.getId()));
        if (recruiters == null) {
            return "view/authen/login.jsp";
        }

        try {
            // Retrieve parameters from the request
            String jobTitle = request.getParameter("jobTitle");
            String jobDescription = request.getParameter("jobDescription");
            String jobRequirements = request.getParameter("jobRequirements");
            String jobLocation = request.getParameter("jobLocation");
            double minSalary = Double.parseDouble(request.getParameter("minSalary"));
            double maxSalary = Double.parseDouble(request.getParameter("maxSalary"));
            String jobStatus = request.getParameter("jobStatus");
            Date postedDate = Date.valueOf(request.getParameter("postedDate"));
            Date closingDate = Date.valueOf(request.getParameter("closingDate"));

            // Retrieve the jobCategory and newCategory from the request
            String jobCategory = request.getParameter("jobCategory"); // This is the value from the dropdown
            String newCategory = request.getParameter("newCategory"); // This is the new category input field
            
            // Set form data back into the request to retain user input
            request.setAttribute("jobTitle", jobTitle);
            request.setAttribute("jobDescription", jobDescription);
            request.setAttribute("jobRequirements", jobRequirements);
            request.setAttribute("jobLocation", jobLocation);
            request.setAttribute("minSalary", minSalary);
            request.setAttribute("maxSalary", maxSalary);
            request.setAttribute("postedDate", postedDate);
            request.setAttribute("closingDate", closingDate);
            request.setAttribute("jobStatus", jobStatus);

            int jobCategoryId;

            // Check if a new category was added
            JobPostings jobPost = new JobPostings();
            if (newCategory != null && !newCategory.trim().isEmpty()) {
                // A new category has been added
                Job_Posting_Category newJobCategory = new Job_Posting_Category();
                newJobCategory.setName(newCategory);

                // Insert new category into the database and get the generated ID
                jobCategoryId = category.insert(newJobCategory);

                // Check if ID was successfully generated
                if (jobCategoryId > 0) {
                    // Set the generated category ID to jobPost
                    jobPost.setJob_Posting_CategoryID(jobCategoryId);
                } else {
                    // Handle the error (e.g., unable to insert category)
                    request.setAttribute("erMess", "Unable to insert new category");
                    return "view/recruiter/addJobPosting.jsp";
                }
            } else {
                // Use the existing category ID selected from the dropdown
                jobCategoryId = Integer.parseInt(jobCategory);
                jobPost.setJob_Posting_CategoryID(jobCategoryId);
            }

            // Create a new JobPostings object and set values
            jobPost.setRecruiterID(recruiters.getRecruiterID());
            jobPost.setTitle(jobTitle);
            jobPost.setDescription(jobDescription);
            jobPost.setRequirements(jobRequirements);
            jobPost.setLocation(jobLocation);
            jobPost.setMinSalary(minSalary);
            jobPost.setMaxSalary(maxSalary);
            jobPost.setStatus(jobStatus);
            jobPost.setPostedDate(postedDate);
            jobPost.setClosingDate(closingDate);
            jobPost.setJob_Posting_CategoryID(jobCategoryId); // Set the category ID (either new or existing)

            List<String> erMess = new ArrayList<>();
            if (!valid.checkAtLeast30Chars(jobDescription)) {
                erMess.add("Description too short");
            }
            if (!valid.checkAtLeast30Chars(jobRequirements)) {
                erMess.add("Requirements too short");
            }
            if (!valid.isValidDateRange(postedDate) || !valid.isValidDateRange(closingDate)) {
                erMess.add("Date month year must be greater than 1990 and less than 2500");
            }
            if (!valid.isStartDateBeforeEndDate(postedDate, closingDate)) {
                erMess.add("Expiration date must be greater than post date");
            }
            if (!valid.isToday(postedDate)) {
                erMess.add("Post date must be current date");
            }
            if (!valid.isValidSalary(minSalary) | !valid.isValidSalary(maxSalary) | !valid.isMaxSalaryGreaterThanMin(maxSalary, minSalary)) {
                erMess.add("Invalid salary");
            }
            if (!erMess.isEmpty()) {
                request.setAttribute("erMess", erMess);
                url = "view/recruiter/addJobPosting.jsp";
            } else {
                // Insert the new job posting into the database
                dao.insert(jobPost);

                // Lấy tham số phân trang hiện tại (nếu có)
                String searchJP = request.getParameter("searchJP") != null ? request.getParameter("searchJP") : "";
                String sortField = request.getParameter("sort") != null ? request.getParameter("sort") : "JobPostingID";
                int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
                int pageSize = 10; // Số lượng bản ghi trên mỗi trang

                // Gọi phương thức để phân trang
                List<JobPostings> jobList;
                int totalRecords;

                if (!searchJP.isEmpty()) {
                    jobList = dao.searchJobPostingByTitleAndRecruiterID(searchJP, recruiters.getRecruiterID(), page);
                    totalRecords = dao.findTotalRecordByTitleAndRecruiterID(searchJP, recruiters.getRecruiterID());
                } else {
                    jobList = dao.findJobPostingsWithFilterAndRecruiterID(sortField, recruiters.getRecruiterID(), page, pageSize);
                    totalRecords = dao.countTotalJobPostingsByRecruiterID(recruiters.getRecruiterID());
                }

                // Tính toán tổng số trang
                int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

                // Gửi các thông tin cần thiết về JSP
                request.setAttribute("listJobPosting", jobList);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("currentPage", page);
                request.setAttribute("sortField", sortField);
                request.setAttribute("searchJP", searchJP);

                // Chuyển hướng đến trang quản lý Job Posting
                url = "view/recruiter/jobPost-manager.jsp";
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("erMess", "An error occurred while adding the job posting.");
            url = "view/recruiter/addJobPosting.jsp";
        }
        return url;
    }

//    private String updateJP(HttpServletRequest request, HttpServletResponse response) {
//        String url;
//        int idJP = Integer.parseInt(request.getParameter("JobPostingID"));
//
//        HttpSession session = request.getSession();
//        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
//        if (account == null) {
//            return "view/authen/login.jsp";
//        }
//        Recruiters recruiters = recruitersDAO.findRecruitersbyAccountID(String.valueOf(account.getId()));
//        if (recruiters == null) {
//            return "view/authen/login.jsp";
//        }
//        // Lấy thông tin bài đăng từ DAO
//        JobPostings jobPost = dao.findJobPostingById(idJP);
//
//        // Lấy các tham số từ form
//        String jobTitle = request.getParameter("jobTitle");
//        String jobDescription = request.getParameter("jobDescription");
//        String jobRequirements = request.getParameter("jobRequirements");
//        String jobLocation = request.getParameter("jobLocation");
//        double jobSalary = Double.parseDouble(request.getParameter("jobSalary"));
//        String jobStatus = request.getParameter("jobStatus");
//        Date postedDate = Date.valueOf(request.getParameter("postedDate"));
//        Date closingDate = Date.valueOf(request.getParameter("closingDate"));
//
//        // Set form data back into the request để giữ lại input của người dùng
//        request.setAttribute("jobTitle", jobTitle);
//        request.setAttribute("jobDescription", jobDescription);
//        request.setAttribute("jobRequirements", jobRequirements);
//        request.setAttribute("jobLocation", jobLocation);
//        request.setAttribute("jobSalary", jobSalary);
//        request.setAttribute("jobStatus", jobStatus);
//        request.setAttribute("postedDate", postedDate);
//        request.setAttribute("closingDate", closingDate);
//
//        // Cập nhật thông tin bài đăng
//        jobPost.setRecruiterID(recruiters.getRecruiterID());
//        jobPost.setTitle(jobTitle);
//        jobPost.setDescription(jobDescription);
//        jobPost.setRequirements(jobRequirements);
//        jobPost.setLocation(jobLocation);
//        jobPost.setSalary(jobSalary);
//        jobPost.setStatus(jobStatus);
//        jobPost.setPostedDate(postedDate);
//        jobPost.setClosingDate(closingDate);
//
//        // Kiểm tra tính hợp lệ của dữ liệu
//        List<String> erMess = new ArrayList<>();
//        if (!valid.checkAtLeast30Chars(jobDescription)) {
//            erMess.add("Description too short");
//        }
//        if (!valid.checkAtLeast30Chars(jobRequirements)) {
//            erMess.add("Requirements too short");
//        }
//        if (!valid.isValidDateRange(postedDate) | !valid.isValidDateRange(closingDate)) {
//            erMess.add("Date month year must be greater than 1990 and less than 2500");
//        }
//        if (!valid.isStartDateBeforeEndDate(postedDate, closingDate)) {
//            erMess.add("Expiration date must be greater than post date");
//        }
//        if (!valid.isValidSalary(jobSalary)) {
//            erMess.add("Invalid salary");
//        }
//        if (!valid.isToday(postedDate)) {
//            erMess.add("Post date must be current date");
//        }
//
//        // Nếu có lỗi, trả về trang chỉnh sửa và hiển thị lỗi
//        if (!erMess.isEmpty()) {
//            request.setAttribute("eM", erMess);
//            url = "view/recruiter/editJP.jsp";
//        } else {
//            // Cập nhật bài đăng trong cơ sở dữ liệu
////            dao.updateJobPosting(jobPost);  // Truyền recruiterID để xác thực cập nhật
////            List<JobPostings> listJobPosting = dao.findAllByRecruiterID(recruiters.getRecruiterID());
////            request.setAttribute("listJobPosting", listJobPosting);
////            url = "view/recruiter/jobPost-manager.jsp";
//// Sau khi cập nhật bài đăng
//            dao.updateJobPosting(jobPost);
//
//// Lấy lại tham số phân trang từ request (page, sortField, searchJP)
//            int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
//            String sortField = request.getParameter("sort") != null ? request.getParameter("sort") : "JobPostingID";
//            String searchJP = request.getParameter("searchJP") != null ? request.getParameter("searchJP") : "";
//
//// Số lượng bản ghi trên mỗi trang
//            int pageSize = 10;
//
//// Gọi phương thức phân trang
//            List<JobPostings> listJobPosting;
//            int totalRecords;
//
//            if (!searchJP.isEmpty()) {
//                listJobPosting = dao.searchJobPostingByTitleAndRecruiterID(searchJP, recruiters.getRecruiterID(), page);
//                totalRecords = dao.findTotalRecordByTitleAndRecruiterID(searchJP, recruiters.getRecruiterID());
//            } else {
//                listJobPosting = dao.findJobPostingsWithFilterAndRecruiterID(sortField, recruiters.getRecruiterID(), page, pageSize);
//                totalRecords = dao.countTotalJobPostingsByRecruiterID(recruiters.getRecruiterID());
//            }
//
//// Tính toán tổng số trang
//            int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
//
//// Gửi các thông tin cần thiết về JSP
//            request.setAttribute("listJobPosting", listJobPosting);
//            request.setAttribute("totalPages", totalPages);
//            request.setAttribute("currentPage", page);
//            request.setAttribute("sortField", sortField);
//            request.setAttribute("searchJP", searchJP);
//
//// Chuyển hướng đến trang quản lý Job Posting
//            url = "view/recruiter/jobPost-manager.jsp";
//
//        }
//
//        return url;
//    }
}
