package controller.recruiter;

import dao.JobPostingsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.JobPostings;

@WebServlet(name = "UpdateJP", urlPatterns = {"/updateJP"})
public class UpdateJP extends HttpServlet {
   @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("idJP"));
        JobPostingsDAO dao = new JobPostingsDAO();
        JobPostings jp = dao.findJobPostingById(id);
        request.setAttribute("jobPost", jp);
        request.getRequestDispatcher("view/recruiter/editJP.jsp").forward(request, response);
    } 
}
