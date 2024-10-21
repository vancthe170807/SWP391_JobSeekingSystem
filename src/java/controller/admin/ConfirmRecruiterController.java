/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.RecruitersDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import model.Recruiters;

@WebServlet(name = "ConfirmRecruiterController", urlPatterns = {"/confirm"})
public class ConfirmRecruiterController extends HttpServlet {

    private static final RecruitersDAO dao = new RecruitersDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "view/admin/confirmRecruiter.jsp";
        List<Recruiters> listConfirm = dao.findAll();
        request.setAttribute("listConfirm", listConfirm);
        request.getRequestDispatcher(url).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url;
        switch (action) {
            case "confirm":
                url = confirm(request, response);
                break;
            case "reject":
                url = reject(request, response);
                break;
            default:
                throw new AssertionError();
        }
        response.sendRedirect(url);
    }

    private String confirm(HttpServletRequest request, HttpServletResponse response) {
        String recruiterId = request.getParameter("recruiterId");
        dao.updateVerification(recruiterId, true);
        return "confirm";
    }

    private String reject(HttpServletRequest request, HttpServletResponse response) {
        String recruiterId = request.getParameter("recruiterId");
        dao.deleteRecruiter(recruiterId);
        return "confirm";
    }

}
