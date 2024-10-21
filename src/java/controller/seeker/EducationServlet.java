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
import java.util.Calendar;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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
        String url = null;

        switch (action) {
            case "update-education":
                url = "view/user/Education.jsp";
                break;

            default: {
                try {
                    url = viewEducation(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().println("Database error.");
                    url = "view/user/Education.jsp";

                }
            }
            // Default page if no action matches
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
            case "delete-education": // New case for delete action
                url = deleteEducation(request);
                break;
            default:
                url = "home"; // Default URL if no action matches
        }

        response.sendRedirect(url);
    }

    // Upload CV
    public String addEducation(HttpServletRequest request) throws IOException, ServletException {
        String url; // URL to navigate to after processing
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        JobSeekers jobSeeker = jobSeekerDAO.findJobSeekerIDByAccountID(String.valueOf(account.getId()));
        List<Education> edus = eduDAO.findEducationbyJobSeekerID(jobSeeker.getJobSeekerID());
        if (jobSeeker != null) {
            try {
                String institution = request.getParameter("institution");
                String degree = request.getParameter("degree");
                String fieldofstudy = request.getParameter("fieldofstudy");
                String startDateStr = request.getParameter("startDate");
                String endDateStr = request.getParameter("endDate");

                Date startDate = Date.valueOf(startDateStr);
                Date endDate = Date.valueOf(endDateStr);

                Calendar startCal = Calendar.getInstance();
                startCal.setTime(startDate);

                Calendar endCal = Calendar.getInstance();
                endCal.setTime(endDate);

                // Tính số năm giữa 2 ngày
                int yearsDiff = endCal.get(Calendar.YEAR) - startCal.get(Calendar.YEAR);
                int monthsDiff = endCal.get(Calendar.MONTH) - startCal.get(Calendar.MONTH);

                // Tính tổng số tháng giữa startDate và endDate
                int totalMonths = yearsDiff * 12 + monthsDiff;

                // Nếu tổng số tháng dưới 24, không lưu và trả về thông báo lỗi
                if (totalMonths < 24) {
                    request.setAttribute("errorEducation", "End date must be at least 2 years after the start date.");
                    url = "education"; // Điều hướng lại trang education với thông báo lỗi
                } else {

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
                    request.setAttribute("edus", edus);
                    request.setAttribute("jobSeeker", jobSeeker);
                    url = "education"; // Điều hướng đến trang Education
                }
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
        List<Education> edus = eduDAO.findEducationbyJobSeekerID(jobSeeker.getJobSeekerID());
        if (jobSeeker != null && edus != null) { // Thay đổi để check đúng edu khác null
            try {
                String educationIDStr = request.getParameter("educationID");
                String institution = request.getParameter("institution");
                String degree = request.getParameter("degree");
                String fieldofstudy = request.getParameter("fieldofstudy");
                String startDateStr = request.getParameter("startDate");
                String endDateStr = request.getParameter("endDate");
                String hiddenEndDate = request.getParameter("hiddenEndDate"); // Lấy giá trị từ hidden field

                int educationID = Integer.parseInt(educationIDStr);
                Date startDate = Date.valueOf(startDateStr);
                Date endDate = Date.valueOf(endDateStr); // Mặc định là null

                Calendar startCal = Calendar.getInstance();
                startCal.setTime(startDate);

                Calendar endCal = Calendar.getInstance();
                endCal.setTime(endDate);

                // Tính số năm giữa 2 ngày
                int yearsDiff = endCal.get(Calendar.YEAR) - startCal.get(Calendar.YEAR);
                int monthsDiff = endCal.get(Calendar.MONTH) - startCal.get(Calendar.MONTH);

                // Tính tổng số tháng giữa startDate và endDate
                int totalMonths = yearsDiff * 12 + monthsDiff;

                // Nếu tổng số tháng dưới 24, không lưu và trả về thông báo lỗi
                if (totalMonths < 24) {
                    request.setAttribute("errorEducation", "End date must be at least 2 years after the start date.");
                    url = "education"; // Điều hướng lại trang education với thông báo lỗi
                } else {

                    Education edu = new Education();

                    // Tạo đối tượng Education
                    edu.setEducationID(educationID);
                    edu.setInstitution(institution);
                    edu.setDegree(degree);
                    edu.setFieldOfStudy(fieldofstudy);
                    edu.setStartDate(startDate);
                    edu.setEndDate(endDate);

                    // Cập nhật bản ghi trong CSDL
                    eduDAO.updateEducation(edu);
                    request.setAttribute("successEducation", "Profile updated successfully.");
                    request.setAttribute("edus", edus);
                    request.setAttribute("jobSeeker", jobSeeker);
                    url = "education"; // Điều hướng đến trang Education
                }

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

    private String viewEducation(HttpServletRequest request, HttpServletResponse response) throws IOException, Exception {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);

        if (account == null) {
            return "view/authen/login.jsp"; // Redirect if user is not logged in
        }

        JobSeekers jobSeeker = jobSeekerDAO.findJobSeekerIDByAccountID(String.valueOf(account.getId()));

        if (jobSeeker == null) {
            request.setAttribute("error", "No Job Seeker found for the current account.");
            return "view/authen/login.jsp"; // Redirect to login page
        }

        // Lấy danh sách học vấn thay vì một đối tượng học vấn đơn lẻ
        List<Education> educationList = eduDAO.findEducationbyJobSeekerID(jobSeeker.getJobSeekerID());

        if (educationList == null || educationList.isEmpty()) {
            request.setAttribute("errorEducation", "No Education found for this Job Seeker.");
            return "view/user/Education.jsp";
        }

        // Set danh sách học vấn vào request attribute
        request.setAttribute("edus", educationList);

        // Forward to the education view page
        return "view/user/Education.jsp";
    }

    // New method to delete education
    public String deleteEducation(HttpServletRequest request) throws IOException, ServletException {
        String url; // URL to navigate to after processing
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        JobSeekers jobSeeker = jobSeekerDAO.findJobSeekerIDByAccountID(String.valueOf(account.getId()));

        if (jobSeeker != null) {
            try {
                String educationIDStr = request.getParameter("educationID");
                int educationID = Integer.parseInt(educationIDStr);

                // Delete the education record
                eduDAO.deleteEducation(educationID);
                request.setAttribute("successEducation", "Education deleted successfully.");
            } catch (Exception e) {
                e.printStackTrace(); // Log the exception for debugging
                request.setAttribute("errorEducation", "An error occurred while deleting the education record. Please try again.");
            }
        } else {
            request.setAttribute("error", "No Job Seeker found for the current account.");
        }

        url = "education"; // Redirect back to the education page
        return url; // Return the URL to navigate to
    }

}
