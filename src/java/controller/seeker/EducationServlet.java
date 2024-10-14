package controller.seeker;

import constant.CommonConst;
import dao.EducationDAO;
import dao.JobSeekerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import model.Account;

import model.Education;
import model.JobSeekers;

@WebServlet(name = "EducationServlet", urlPatterns = {"/education"})
public class EducationServlet extends HttpServlet {

    private final EducationDAO eduDAO = new EducationDAO();
    private final JobSeekerDAO jobSeekerDAO = new JobSeekerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url;

        switch (action) {
            case "add-education":
                url = "view/user/Education.jsp";
                break;
            case "update-education":
                url = "view/user/Education.jsp";
                break;

            default:
                url = "view/authen/login.jsp"; // Default page if no action matches
                break;
        }

        request.getRequestDispatcher(url).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url;

        switch (action) {
            case "add-education":
                url = addEducation(request);
                break;
            case "update-education":
                url = updateEducation(request);
                break;
            default:
                url = "home"; // Default URL if no action matches
        }

        request.getRequestDispatcher(url).forward(request, response);
    }

    // Upload CV
    public String addEducation(HttpServletRequest request) throws IOException, ServletException {
        String url; // URL to navigate to after processing
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        JobSeekers jobSeeker = jobSeekerDAO.findJobSeekerIDByAccountID(String.valueOf(account.getId()));
        Education edu = eduDAO.findEducationbyJobSeekerID(jobSeeker.getJobSeekerID());
        if (jobSeeker != null && edu == null) {
            try {
                String institution = request.getParameter("institution");
                String degree = request.getParameter("degree");
                String fieldofstudy = request.getParameter("fieldofstudy");
                String startDateStr = request.getParameter("startDate");
                String endDateStr = request.getParameter("endDate");
                String hiddenEndDate = request.getParameter("hiddenEndDate"); // Lấy giá trị từ hidden field

                Date startDate = Date.valueOf(startDateStr);
                Date endDate = null; // Mặc định là null

                if (hiddenEndDate == null || !hiddenEndDate.equals("N/A")) {
                    // Nếu người dùng có nhập End Date, chuyển đổi thành kiểu Date
                    endDate = Date.valueOf(endDateStr);
                }

                // Tạo đối tượng Education
                Education eduAdd = new Education();
                eduAdd.setJobSeekerID(jobSeeker.getJobSeekerID());
                eduAdd.setInstitution(institution);
                eduAdd.setDegree(degree);
                eduAdd.setFieldOfStudy(fieldofstudy);
                eduAdd.setStartDate(startDate);
                eduAdd.setEndDate(endDate);

                // Thêm bản ghi vào CSDL
                eduDAO.insert(eduAdd);
                request.setAttribute("successEducation", "Profile uploaded successfully.");
                request.setAttribute("edu", edu);
                request.setAttribute("jobSeeker", jobSeeker);
                url = "view/user/Education.jsp"; // Điều hướng đến trang Education
            } catch (Exception e) {
                e.printStackTrace(); // Log the exception for debugging
                request.setAttribute("errorEducation", "An error occurred while uploading the profile. Please try again.");
                url = "view/user/Education.jsp"; // Redirect back to Education upload page with error
            }
        } else {
            request.setAttribute("error", "No Job Seeker found for the current account.");
            url = "view/authen/login.jsp"; // Redirect to login page
        }

        return url; // Return the URL to navigate to
    }

//Update CV
    public String updateEducation(HttpServletRequest request) throws IOException, ServletException {
        String url; // URL to navigate to after processing
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        JobSeekers jobSeeker = jobSeekerDAO.findJobSeekerIDByAccountID(String.valueOf(account.getId()));
        Education edu = eduDAO.findEducationbyJobSeekerID(jobSeeker.getJobSeekerID());
        if (jobSeeker != null && edu != null) { // Thay đổi để check đúng edu khác null
            try {
                String institution = request.getParameter("institution");
                String degree = request.getParameter("degree");
                String fieldofstudy = request.getParameter("fieldofstudy");
                String startDateStr = request.getParameter("startDate");
                String endDateStr = request.getParameter("endDate");
                String hiddenEndDate = request.getParameter("hiddenEndDate"); // Lấy giá trị từ hidden field

                Date startDate = Date.valueOf(startDateStr);
                Date endDate = null; // Mặc định là null

                if (hiddenEndDate == null || !hiddenEndDate.equals("N/A")) {
                    // Nếu người dùng có nhập End Date, chuyển đổi thành kiểu Date
                    endDate = Date.valueOf(endDateStr);
                }

                // Tạo đối tượng Education
                edu.setInstitution(institution);
                edu.setDegree(degree);
                edu.setFieldOfStudy(fieldofstudy);
                edu.setStartDate(startDate);
                edu.setEndDate(endDate);

                // Cập nhật bản ghi trong CSDL
                eduDAO.updateEducation(edu);
                request.setAttribute("successEducation", "Profile updated successfully.");
                request.setAttribute("edu", edu);
                request.setAttribute("jobSeeker", jobSeeker);
                url = "view/user/Education.jsp"; // Điều hướng đến trang Education
            } catch (Exception e) {
                e.printStackTrace(); // Log the exception for debugging
                request.setAttribute("errorEducation", "An error occurred while updating the profile. Please try again.");
                url = "view/user/Education.jsp"; // Redirect back to Education upload page with error
            }
        } else {
            request.setAttribute("error", "No Job Seeker found for the current account.");
            url = "view/authen/login.jsp"; // Redirect to login page
        }

        return url; // Return the URL to navigate to
    }

}
