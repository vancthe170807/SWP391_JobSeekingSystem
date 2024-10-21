package controller.recruiter;

import dao.JobPostingsDAO;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DeleteJP", urlPatterns = {"/deleteJP"})
public class DeleteJP extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("idJP");
        JobPostingsDAO dao = new JobPostingsDAO();
        dao.deleteJobPosting(id);
        response.sendRedirect("jobPost");
    }    
}
