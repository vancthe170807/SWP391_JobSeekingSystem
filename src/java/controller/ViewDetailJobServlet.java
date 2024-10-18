/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

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

@WebServlet(name="ViewDetailJobServlet", urlPatterns={"/viewdetail"})
public class ViewDetailJobServlet extends HttpServlet {
   
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
                url = "view/ViewJobPosting.jsp";
        }
        request.getRequestDispatcher(url).forward(request, response);
    }

    private String viewJP(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = null;
        int idJP = Integer.parseInt(request.getParameter("idJP"));
        JobPostings jobPost = dao.findJobPostingById(idJP);
        request.setAttribute("jobPost", jobPost);
        url = "view/ViewJobPosting.jsp";
        return url;
    }

}
