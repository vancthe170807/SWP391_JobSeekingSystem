package controller.seeker;

import constant.CommonConst;
import dao.JobSeekerDAO;
import dao.WorkExperienceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import model.Account;
import model.JobSeekers;
import model.WorkExperience;

@WebServlet(name = "ExperienceServlet", urlPatterns = {"/experience"})
public class ExperienceServlet extends HttpServlet {

    private final WorkExperienceDAO weDAO = new WorkExperienceDAO();
    private final JobSeekerDAO jobSeekerDAO = new JobSeekerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url = null;

        switch (action) {
            case "update-experience":
                url = "view/user/Experience.jsp";
                break;

            default: {
                try {
                    url = viewExperience(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().println("Database error.");
                    url = "view/user/Experience.jsp";
                }
            }
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
            case "add-experience":
                url = addExperience(request);
                break;
            case "update-experience":
                url = updateExperience(request);
                break;
            case "delete-experience": // New case for delete action
                url = deleteExperience(request);
                break;
            default:
                url = "experience"; // Redirect to the experience list page by default
        }

        response.sendRedirect(url);
    }

    // Add new work experience
    public String addExperience(HttpServletRequest request) throws IOException, ServletException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        JobSeekers jobSeeker = jobSeekerDAO.findJobSeekerIDByAccountID(String.valueOf(account.getId()));

        if (jobSeeker != null) {
            try {
                String companyName = request.getParameter("companyName");
                String jobTitle = request.getParameter("jobTitle");
                String startDateStr = request.getParameter("startDate");
                String endDateStr = request.getParameter("endDate");
                String description = request.getParameter("description");

                Date startDate = Date.valueOf(startDateStr);
                Date endDate = Date.valueOf(endDateStr);

                WorkExperience weAdd = new WorkExperience();
                weAdd.setJobSeekerID(jobSeeker.getJobSeekerID());
                weAdd.setCompanyName(companyName);
                weAdd.setJobTitle(jobTitle);
                weAdd.setStartDate(startDate);
                weAdd.setEndDate(endDate);
                weAdd.setDescription(description);

                weDAO.insert(weAdd); // Insert work experience

                // Reload updated list after insertion
                List<WorkExperience> wes = weDAO.findWorkExperiencesbyJobSeekerID(jobSeeker.getJobSeekerID());
                request.setAttribute("successExperience", "Experience added successfully.");
                request.setAttribute("wes", wes);
                request.setAttribute("jobSeeker", jobSeeker);

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorExperience", "An error occurred while adding the experience.");
            }
        } else {
            request.setAttribute("error", "No Job Seeker found for the current account.");
        }

        return "experience"; // Redirect to experience page
    }

    // Update work experience
    public String updateExperience(HttpServletRequest request) throws IOException, ServletException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        JobSeekers jobSeeker = jobSeekerDAO.findJobSeekerIDByAccountID(String.valueOf(account.getId()));

        if (jobSeeker != null) {
            try {
                String experienceIDStr = request.getParameter("experienceID");
                String companyName = request.getParameter("companyName");
                String jobTitle = request.getParameter("jobTitle");
                String startDateStr = request.getParameter("startDate");
                String endDateStr = request.getParameter("endDate");
                String description = request.getParameter("description");

                int experienceID = Integer.parseInt(experienceIDStr);
                Date startDate = Date.valueOf(startDateStr);
                Date endDate = Date.valueOf(endDateStr);

                WorkExperience weUpdate = new WorkExperience();
                weUpdate.setExperienceID(experienceID);
                weUpdate.setCompanyName(companyName);
                weUpdate.setJobTitle(jobTitle);
                weUpdate.setStartDate(startDate);
                weUpdate.setEndDate(endDate);
                weUpdate.setDescription(description);

                weDAO.updateExperience(weUpdate); // Update experience

                // Reload updated list after update
                List<WorkExperience> wes = weDAO.findWorkExperiencesbyJobSeekerID(jobSeeker.getJobSeekerID());
                request.setAttribute("successExperience", "Experience updated successfully.");
                request.setAttribute("wes", wes);
                request.setAttribute("jobSeeker", jobSeeker);

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorExperience", "An error occurred while updating the experience.");
            }
        } else {
            request.setAttribute("error", "No Job Seeker found for the current account.");
        }

        return "experience"; // Redirect to experience page
    }

    // View work experience
    private String viewExperience(HttpServletRequest request, HttpServletResponse response) throws IOException, Exception {
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

        List<WorkExperience> weList = weDAO.findWorkExperiencesbyJobSeekerID(jobSeeker.getJobSeekerID());

        if (weList == null || weList.isEmpty()) {
            request.setAttribute("errorExperience", "No experience found for this Job Seeker.");
            return "view/user/Experience.jsp";
        }

        request.setAttribute("wes", weList);

        return "view/user/Experience.jsp";
    }

    // Delete work experience
    public String deleteExperience(HttpServletRequest request) throws IOException, ServletException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        JobSeekers jobSeeker = jobSeekerDAO.findJobSeekerIDByAccountID(String.valueOf(account.getId()));

        if (jobSeeker != null) {
            try {
                String experienceIDStr = request.getParameter("experienceID");
                int experienceID = Integer.parseInt(experienceIDStr);

                weDAO.deleteExperience(experienceID); // Delete work experience
                request.setAttribute("successExperience", "Experience deleted successfully.");

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorExperience", "An error occurred while deleting the experience.");
            }
        } else {
            request.setAttribute("error", "No Job Seeker found for the current account.");
        }

        return "experience"; // Redirect to experience page
    }
}
