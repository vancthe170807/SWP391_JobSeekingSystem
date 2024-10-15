package controller.recruiter;

import dao.JobPostingsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.JobPostings;
import validate.Validation;

@WebServlet(name = "EditDetail", urlPatterns = {"/EditDetail"})
public class EditDetail extends HttpServlet {

    JobPostingsDAO dao = new JobPostingsDAO();
    Validation valid = new Validation();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url;
        switch (action) {
            case "edit":
                url = editJP(request, response);
                break;
            default:
                url = "view/recruiter/editJP.jsp";
        }
        request.getRequestDispatcher(url).forward(request, response);
    }

    private String editJP(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = null;
        int idJP = Integer.parseInt(request.getParameter("idJP"));
        JobPostings jobPost = dao.findJobPostingById(idJP);
        request.setAttribute("jobPost", jobPost);
        url = "view/recruiter/editJP.jsp";
        return url;
    }

}
