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

@WebServlet(name = "JobSeekerCheck", urlPatterns = {"/JobSeekerCheck"})
public class JobSeekerCheck extends HttpServlet {

    AccountDAO accountDAO = new AccountDAO();
    JobSeekerDAO jobSeekerDAO = new JobSeekerDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Account account = new Account();
        account.setUsername(username);
        account.setPassword(password);

        // Check the account in the Account table
        Account accFound = accountDAO.findUserByUsernameAndPassword(account);

        if (accFound != null) {
            HttpSession session = request.getSession();
            session.setAttribute("account", accFound);
            // Log for debugging
            System.out.println("Account ID: " + accFound.getId());

            JobSeekers jobSeekerFound = jobSeekerDAO.findJobSeekerByAccountID(accFound.getId());
            if (jobSeekerFound != null) {
                session.setAttribute("jobSeekerID", jobSeekerFound.getJobSeekerID());
                // Log for debugging
                System.out.println("Job Seeker ID: " + jobSeekerFound.getJobSeekerID());
            } else {
                session.setAttribute("jobSeekerID", null);
            }

            response.sendRedirect("view/user/userProfile.jsp");
        } else {
            // Handle invalid login
            response.sendRedirect("login.jsp?error=Invalid credentials");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Get session if exists, don't create new one
        if (session != null && session.getAttribute("account") != null) {
            // If account exists in session, redirect to profile
            response.sendRedirect("view/user/userProfile.jsp");
        } else {
            // Otherwise, redirect to login page
            response.sendRedirect("login.jsp");
        }
    }
}
