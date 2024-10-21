/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.AccountDAO;
import dao.RecruitersDAO;
import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.Recruiters;
import utils.Email;

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

    private String reject(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            //tao doi tuong account de lay ve mail
            AccountDAO accountDao = new AccountDAO();
            String recruiterId = request.getParameter("recruiterId");
            //lay recruiter theo id de lay ve id cua account do
            Recruiters recruiter =  dao.findById(recruiterId);
            Account accountFound = accountDao.findUserById(recruiter.getAccountID());
            //gui email ve email cua account vua tim duoc
            Email.sendEmail(accountFound.getEmail(), "RESPONE FOR YOUR REQUEST!!!", "Your request to become recruiter was reject!!");
            dao.deleteRecruiter(recruiterId);
            return "confirm";
        } catch (MessagingException ex) {
            request.setAttribute("errorSendEmail", "Email can not send!!");
            request.getRequestDispatcher("view/admin/confirmRecruiter.jsp").forward(request, response);
        }
        return "confirm";
    }

}
