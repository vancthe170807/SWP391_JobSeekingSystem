package controller.seeker;

import constant.CommonConst;
import dao.CVDAO;
import dao.JobSeekerDAO;
import model.CV;
import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.nio.file.Files;
import model.Account;
import model.JobSeekers;

@WebServlet(name = "CVServlet", urlPatterns = {"/cv"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1MB
        maxFileSize = 1024 * 1024 * 10, // 10MB (dung luong toi da cho 1 tep)
        maxRequestSize = 1024 * 1024 * 15)   // 15MB
public class CVServlet extends HttpServlet {

    private final CVDAO cvDAO = new CVDAO();
    private final JobSeekerDAO jobSeekerDAO = new JobSeekerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        switch (action) {
            case "view-cv":
                viewCV(request, response);
                break;
            case "update-cv":
                request.getRequestDispatcher("view/user/CV.jsp").forward(request, response);
                break;
            default: {
                // Default action to display the CV page
                HttpSession session = request.getSession();
                Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
                if (account == null) {
                    response.sendRedirect("view/authen/login.jsp"); // Redirect if not logged in
                    return;
                }
                JobSeekers jobSeeker = jobSeekerDAO.findJobSeekerIDByAccountID(String.valueOf(account.getId()));
                if (jobSeeker != null) {
                    CV cv = cvDAO.findCVbyJobSeekerID(jobSeeker.getJobSeekerID());
                    if (cv != null) {
                        request.setAttribute("cvFilePath", cv.getFilePath());
                    }
                }
            }
            request.getRequestDispatcher("view/user/CV.jsp").forward(request, response); // Default page
            break;
        }
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
                url = "cv"; // Default URL if no action matches
        }
        response.sendRedirect(url);
    }

    // Upload CV
    public String uploadCV(HttpServletRequest request) throws IOException, ServletException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);

        if (account == null) {
            return "view/authen/login.jsp"; // Redirect if the user is not logged in
        }

        JobSeekers jobSeeker = jobSeekerDAO.findJobSeekerIDByAccountID(String.valueOf(account.getId()));
        if (jobSeeker == null) {
            request.setAttribute("error", "No Job Seeker found for the current account.");
            return "view/user/CV.jsp"; // Redirect if no JobSeeker is found
        }

        CV existingCV = cvDAO.findCVbyJobSeekerID(jobSeeker.getJobSeekerID());
        if (existingCV != null) {
            request.setAttribute("error", "CV already exists. Please update it instead.");
            return "view/user/CV.jsp"; // Redirect if CV already exists
        }

        try {
            Part part = request.getPart("cvUploadFile");
            if (part == null || part.getSize() <= 0) {
                request.setAttribute("errorCV", "No file uploaded. Please select a CV file.");
                return "view/user/CV.jsp"; // Redirect if no file is uploaded
            }

            // Validate that the uploaded file is a PDF
            String fileName = part.getSubmittedFileName();
            if (!fileName.toLowerCase().endsWith(".pdf")) {
                request.setAttribute("errorCV", "Invalid file type. Please upload a PDF file.");
                return "view/user/CV.jsp"; // Redirect if the file is not a PDF
            }

            // Define the directory path for storing CV files
            String path = request.getServletContext().getRealPath("cvFiles");
            File dir = new File(path);
            if (!dir.exists()) {
                dir.mkdirs(); // Create the directory if it doesn't exist
            }

            // Save the uploaded file
            File cvFile = new File(dir, fileName);
            part.write(cvFile.getAbsolutePath());

            // Insert CV record into the database
            CV newCV = new CV();
            newCV.setJobSeekerID(jobSeeker.getJobSeekerID());
            newCV.setFilePath(request.getContextPath() + "/cvFiles/" + cvFile.getName());
            newCV.setUploadDate(Date.valueOf(LocalDate.now()));
            cvDAO.insert(newCV);

            // Set success message and return to the CV page
            request.setAttribute("successCV", "CV uploaded successfully.");
            return "cv";
        } catch (IllegalStateException e) {
            // Handle file size exceeding the limit
            request.setAttribute("errorCV", "File upload exceeds the maximum allowed size (10MB).");
            return "view/user/CV.jsp"; // Redirect with size error
        } catch (Exception e) {
            // Handle any other errors during the upload process
            e.printStackTrace();
            request.setAttribute("errorCV", "An error occurred while uploading the CV: " + e.getMessage());
            return "view/user/CV.jsp"; // Redirect with generic error
        }
    }

    // Update CV
    public String updateCV(HttpServletRequest request) throws IOException, ServletException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        if (account == null) {
            return "view/authen/login.jsp";
        }
        JobSeekers jobSeeker = jobSeekerDAO.findJobSeekerIDByAccountID(String.valueOf(account.getId()));
        if (jobSeeker == null) {
            request.setAttribute("errorCV", "No Job Seeker found for the current account.");
            return "view/user/CV.jsp";
        }
        CV existingCV = cvDAO.findCVbyJobSeekerID(jobSeeker.getJobSeekerID());
        if (existingCV == null) {
            request.setAttribute("errorCV", "No CV found. Please upload one first.");
            return "view/user/CV.jsp";
        }

        try {
            Part part = request.getPart("cvFileU");
            if (part == null || part.getSize() <= 0) {
                request.setAttribute("errorCV", "No file uploaded. Please select a CV file.");
                return "view/user/CV.jsp";
            }
            String path = request.getServletContext().getRealPath("cvFiles");
            File dir = new File(path);
            // Create directory if it doesn't exist
            if (!dir.exists()) {
                dir.mkdirs();
            }
            // Save updated file
            File cvFile = new File(dir, part.getSubmittedFileName());
            part.write(cvFile.getAbsolutePath());
            // Update CV record in the database
            existingCV.setFilePath(request.getContextPath() + "/cvFiles/" + cvFile.getName());
            existingCV.setUploadDate(Date.valueOf(LocalDate.now()));
            cvDAO.updateCV(existingCV);

            request.setAttribute("successCV", "CV updated successfully.");
            return "cv";
        } catch (IllegalStateException e) {
            // Handle file size exceeding the limit
            request.setAttribute("errorCV", "File upload exceeds the maximum allowed size (10MB).");
            return "view/user/CV.jsp"; // Redirect with size error
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorCV", "An error occurred while updating the CV: " + e.getMessage());
            return "view/user/CV.jsp";
        }
    }

    // View CV
    private void viewCV(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        if (account == null) {
            response.sendRedirect("view/authen/login.jsp"); // Redirect if user is not logged in
            return;
        }
        JobSeekers jobSeeker = jobSeekerDAO.findJobSeekerIDByAccountID(String.valueOf(account.getId()));
        if (jobSeeker == null) {
            request.setAttribute("error", "No Job Seeker found for the current account.");
            request.getRequestDispatcher("view/authen/login.jsp").forward(request, response); // Redirect to login page
            return;
        }
        CV cv = cvDAO.findCVbyJobSeekerID(jobSeeker.getJobSeekerID());
        if (cv == null) {
            request.setAttribute("errorCV", "No CV found for this Job Seeker.");
            request.getRequestDispatcher("view/user/CV.jsp").forward(request, response);
            return;
        }

        // Get the file path from the database
        String filePath = cv.getFilePath(); // Example: /cvFile/1721092306015_6454ae59431b066cbfda5ca4_PE1-SWR-Sample.pdf
        String rootPath = request.getServletContext().getRealPath("/");

        // Ensure the path uses the 'cvFile' directory
        String relativeFilePath = filePath.replace("JobSeeker/cvFiles/", "cvFiles/");

        // Concatenate root and file path
        String absoluteFilePath = rootPath + relativeFilePath;

        // Normalize the file path slashes for Windows systems
        absoluteFilePath = absoluteFilePath.replace("/", "\\").replace("\\\\", "\\");

        File file = new File(absoluteFilePath);
        if (!file.exists()) {
            request.setAttribute("errorCV", "File not found.");
            request.getRequestDispatcher("view/user/CV.jsp").forward(request, response);
            return;
        }

        // Set response headers and content type for PDF viewing
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=\"" + file.getName() + "\"");

        // Stream the file content to the browser
        try {
            Files.copy(file.toPath(), response.getOutputStream());
            response.getOutputStream().flush();
        } catch (IOException e) {
            e.printStackTrace(); // Log the error for debugging
            request.setAttribute("errorCV", "Error displaying CV: " + e.getMessage());
            request.getRequestDispatcher("view/user/CV.jsp").forward(request, response);
        }
    }
}
