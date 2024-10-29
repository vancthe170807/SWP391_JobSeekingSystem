/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.seeker;

import constant.CommonConst;
import dao.JobPostingsDAO;
import dao.Job_Posting_CategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.JobPostings;
import model.Job_Posting_Category;
import validate.Validation;

@WebServlet(name = "ViewDetailJobPostingServlet", urlPatterns = {"/jobPostingDetail"})
public class ViewDetailJobPostingServlet extends HttpServlet {

    Job_Posting_CategoryDAO categoryDAO = new Job_Posting_CategoryDAO();
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
                url = "view/user/ViewJobPosting.jsp";
        }
        request.getRequestDispatcher(url).forward(request, response);
    }

    private String viewJP(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = null;
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);

        if (account == null) {
            return "home"; // Redirect if the user is not logged in
        } else {
            int idJP = Integer.parseInt(request.getParameter("idJP"));
            JobPostings jobPost = dao.findJobPostingById(idJP);
            request.setAttribute("jobPost", jobPost);
            Job_Posting_Category category = categoryDAO.findJob_Posting_CategoryNameByJobPostingID(idJP);
            request.setAttribute("category", category); // Đặt với tên 'category'
            url = "view/user/ViewJobPosting.jsp";
            return url;
        }
    }

}
