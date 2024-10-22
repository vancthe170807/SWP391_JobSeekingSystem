package controller.recruiter;

import dao.JobPostingsDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.JobPostings;
import validate.Validation;

@WebServlet(name = "DetailsJP", urlPatterns = {"/detailsJP"})
public class DetailsJP extends HttpServlet {

    JobPostingsDAO dao = new JobPostingsDAO();
    Validation valid = new Validation();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url;
        switch (action) {
            case "details":
                url = viewJP(request, response);
                break;
            default:
                url = "view/recruiter/viewJP.jsp";
        }
        request.getRequestDispatcher(url).forward(request, response);
    }

    private String viewJP(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = null;
        int idJP = Integer.parseInt(request.getParameter("idJP"));
        JobPostings jobPost = dao.findJobPostingById(idJP);
        request.setAttribute("jobPost", jobPost);
        url = "view/recruiter/viewJP.jsp";
        return url;
    }
}
