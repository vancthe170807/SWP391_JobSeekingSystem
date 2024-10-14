package controller.seeker;

import constant.CommonConst;
import dao.CVDAO;
import dao.JobSeekerDAO;
import model.CV;
import java.io.IOException;
import java.io.File;
import java.sql.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.time.LocalDate;
import model.Account;
import model.JobSeekers;

@WebServlet(name = "CVServlet", urlPatterns = {"/cv"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 15)   // 15MB
public class CVServlet extends HttpServlet {

    private final CVDAO cvDAO = new CVDAO();
    private final JobSeekerDAO jobSeekerDAO = new JobSeekerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url;

        switch (action) {
            case "upload-cv":
                url = "view/user/CV.jsp";
                break;
            case "update-cv":
                url = "view/user/CV.jsp";
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
            case "upload-cv":
                url = uploadCV(request);
                break;
            case "update-cv":
                url = updateCV(request);
                break;
            default:
                url = "home"; // Default URL if no action matches
        }

        request.getRequestDispatcher(url).forward(request, response);
    }

    // Upload CV
    public String uploadCV(HttpServletRequest request) throws IOException, ServletException {
        String url; // URL to navigate to after processing
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        JobSeekers jobSeeker = jobSeekerDAO.findJobSeekerIDByAccountID(String.valueOf(account.getId()));
        CV cv = cvDAO.findCVbyJobSeekerID(jobSeeker.getJobSeekerID());
        if (jobSeeker != null && cv == null) {
            try {
                Part part = request.getPart("cvFile");
                String cvFilePath = null;

                // Check if the uploaded file is valid
                if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().trim().isEmpty()) {
                    String path = request.getServletContext().getRealPath("cvFiles");
                    File dir = new File(path);

                    // Create directory if it doesn't exist
                    if (!dir.exists()) {
                        dir.mkdirs();
                    }

                    // Create file object for the CV
                    File cvFile = new File(dir, part.getSubmittedFileName());
                    part.write(cvFile.getAbsolutePath()); // Write file to the server

                    // Store the file path for database insertion
                    cvFilePath = request.getContextPath() + "/cvFiles/" + cvFile.getName();
                } else {
                    // Handle case where no file was uploaded
                    request.setAttribute("errorCV", "No file uploaded. Please select a CV file.");
                    return "view/user/CV.jsp"; // Redirect back to CV upload page with error
                }

                // Create CV object for update
                CV cvUpdate = new CV();
                cvUpdate.setJobSeekerID(jobSeeker.getJobSeekerID());
                cvUpdate.setFilePath(cvFilePath);
                cvUpdate.setUploadDate(Date.valueOf(LocalDate.now())); // Set the last updated date

                // Update the CV in the database
                cvDAO.insert(cvUpdate);
                request.setAttribute("successCV", "Profile uploaded successfully.");
                request.setAttribute("cv", cv);
                request.setAttribute("jobSeeker", jobSeeker);
                url = "view/user/CV.jsp"; // Navigate to CV page
            } catch (Exception e) {
                e.printStackTrace(); // Log the exception for debugging
                request.setAttribute("errorCV", "An error occurred while uploading the CV. Please try again.");
                url = "view/user/CV.jsp"; // Redirect back to CV upload page with error
            }
            request.setAttribute("cv", cv);
            request.setAttribute("jobSeeker", jobSeeker);
        } else {
            // If no JobSeeker is found, handle the error
            request.setAttribute("error", "No Job Seeker found for the current account.");
            url = "view/authen/login.jsp"; // Redirect to login page

        }

        return url; // Return the URL to navigate to
    }

//Update CV
    public String updateCV(HttpServletRequest request) throws IOException, ServletException {
        String url; // URL to navigate to after processing
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        JobSeekers jobSeeker = jobSeekerDAO.findJobSeekerIDByAccountID(String.valueOf(account.getId()));
        CV cv = cvDAO.findCVbyJobSeekerID(jobSeeker.getJobSeekerID());

        if (jobSeeker != null && cv != null) {
                try {
                    Part part = request.getPart("cvFile");
                    String cvFilePath = null;

                    // Check if the uploaded file is valid
                    if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().trim().isEmpty()) {
                        String path = request.getServletContext().getRealPath("cvFiles");
                        File dir = new File(path);

                        // Create directory if it doesn't exist
                        if (!dir.exists()) {
                            dir.mkdirs();
                        }

                        // Create file object for the CV
                        File cvFile = new File(dir, part.getSubmittedFileName());
                        part.write(cvFile.getAbsolutePath()); // Write file to the server

                        // Store the file path for database insertion
                        cvFilePath = request.getContextPath() + "/cvFiles/" + cvFile.getName();
                    } else {
                        // Handle case where no file was uploaded
                        request.setAttribute("errorCV", "No file uploaded. Please select a CV file.");
                        return "view/user/CV.jsp"; // Redirect back to CV upload page with error
                    }

                    // Create CV object for update
                    CV cvUpdate = new CV();
                    cvUpdate.setJobSeekerID(jobSeeker.getJobSeekerID());
                    cvUpdate.setFilePath(cvFilePath);
                    cvUpdate.setLastUpdated(Date.valueOf(LocalDate.now())); // Set the last updated date

                    // Update the CV in the database
                    cvDAO.updateCV(cvUpdate);
                    request.setAttribute("successCV", "Profile updated successfully.");
                    request.setAttribute("cv", cv);
                    request.setAttribute("jobSeeker", jobSeeker);
                    url = "view/user/CV.jsp"; // Navigate to CV page
                } catch (Exception e) {
                    e.printStackTrace(); // Log the exception for debugging
                    request.setAttribute("errorCV", "An error occurred while updating the CV. Please try again.");
                    url = "view/user/CV.jsp"; // Redirect back to CV upload page with error
                }
                request.setAttribute("cv", cv);
            request.setAttribute("jobSeeker", jobSeeker);
        } else {
            // If no JobSeeker is found, handle the error
            request.setAttribute("error", "No Job Seeker found for the current account.");
            url = "view/authen/login.jsp"; // Redirect to login page
        }

        return url; // Return the URL to navigate to
    }

}
