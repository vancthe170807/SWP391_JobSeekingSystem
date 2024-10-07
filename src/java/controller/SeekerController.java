package controller;

import constant.CommonConst;
import dao.JobSeekerDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.JobSeekers;
import validate.Validation;

@WebServlet(name = "SeekerController", urlPatterns = {"/seeker"})
public class SeekerController extends HttpServlet {

    private final JobSeekerDAO jobSeekerDAO = new JobSeekerDAO();
    Validation valid = new Validation();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get action parameter
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url;

        // Handle GET requests based on the action
        switch (action) {
            case "join-job-seeking":
                url = "view/user/JoinJobSeeking.jsp";
                break;

            case "checkJobSeeker":
                url = checkJobSeeker(request);
                break;

            default:
                url = "view/authen/login.jsp"; // Default page if no action matches
                break;
        }

        // Forward to the appropriate page
        request.getRequestDispatcher(url).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get action parameter
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url;

        // Handle POST requests based on the action
        switch (action) {
            case "join-job-seeking":
                url = joinJobSeeking(request);
                break;

            case "checkJobSeeker":
                url = checkJobSeeker(request);
                break;

            default:
                url = "home"; // Default URL if no action matches
        }

        // Forward to the appropriate page
        request.getRequestDispatcher(url).forward(request, response);
    }

    // Bật chức năng tìm việc để ghi vào DB JobSeeker
    private String joinJobSeeking(HttpServletRequest request) {
        String url = "view/user/userHome.jsp";

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);

        // Log để kiểm tra Account có được nhận từ session không
        if (account == null) {
            System.out.println("Account is null. User might not be logged in.");
            request.setAttribute("joinerror", "Unable to join job seeking. Please log in first.");
            return "view/authen/login.jsp";
        }

        int accountId = account.getId();
        request.setAttribute("accountid", accountId);

        // Kiểm tra việc tạo đối tượng JobSeeker
        JobSeekers jobSeeker = new JobSeekers();
        jobSeeker.setAccountID(accountId);

        try {
            // Kiểm tra xem có lỗi trong khi chèn dữ liệu vào DB không
            jobSeekerDAO.insert(jobSeeker);
            System.out.println("Job seeker inserted successfully with AccountID: " + accountId);
            request.setAttribute("joinsuccess", "Confirmed! You have successfully joined Job Seeking.");
        } catch (Exception e) {
            // Log ngoại lệ khi xảy ra lỗi
            System.out.println("Error inserting job seeker: " + e.getMessage());
            request.setAttribute("joinerror", "Failed to join job seeking. Please try again later.");
        }

        return url;
    }

    // Hàm để kiểm tra người dùng có phải là Job Seeker
    private String checkJobSeeker(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        String url = "view/common/user/header-user.jsp"; // Default URL to forward to

        if (account != null) {
            int accountId = account.getId();
            JobSeekers jobSeeker = jobSeekerDAO.findJobSeekerByAccountID(accountId);

            if (jobSeeker != null) {
                // Nếu đã tham gia, đặt thông tin JobSeeker vào request
                request.setAttribute("jobSeekerInfo", jobSeeker.getJobSeekerID());
            } else {
                // Nếu chưa tham gia, đặt flag hiển thị nút Join Job Seeking
                request.setAttribute("showJoinJobSeekingButton", true);
            }
        } else {
            // Nếu chưa đăng nhập, điều hướng đến trang login
            url = "view/authen/login.jsp";
        }

        return url;
    }
    
    //Nhap CV

    
    //Nhap thong tin hoc van
    
    
    //Nhap thong tin so thich
}