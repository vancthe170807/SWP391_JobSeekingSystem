package controller.seeker;

import dao.AccountDAO;
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
import java.util.logging.Logger;
import java.util.logging.Level;

@WebServlet(name = "JobSeekerCheck", urlPatterns = {"/JobSeekerCheck"})
public class JobSeekerCheck extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Giả sử bạn đã có accountId từ session
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        
        if (username != null) {
            JobSeekerDAO jobSeekerDAO = new JobSeekerDAO();
            JobSeekers jobSeeker = jobSeekerDAO.findJobSeekerIDByUsername(username);
            
            request.setAttribute("jobSeeker", jobSeeker);
        }
        
        request.getRequestDispatcher("userProfile.jsp").forward(request, response);
    }
}