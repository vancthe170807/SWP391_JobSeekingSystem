/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.recruiter;

import constant.CommonConst;
import dao.JobPostingsDAO;
import dao.RecruitersDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.JobPostings;
import model.Recruiters;


@WebServlet(name = "Dashboard", urlPatterns = {"/Dashboard"})
public class Dashboard extends HttpServlet {
    JobPostingsDAO jobPostingsDAO = new JobPostingsDAO();
    RecruitersDAO RecruitersDAO = new RecruitersDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        Recruiters recruiters = RecruitersDAO.findRecruitersbyAccountID(String.valueOf(account.getId()));
        List<JobPostings> listSize = jobPostingsDAO.findJobPostingbyRecruitersID(recruiters.getRecruiterID());
        List<JobPostings> listTop5 = jobPostingsDAO.getTop5RecentJobPostingsByRecruiterID(recruiters.getRecruiterID());

        // Gửi dữ liệu đến JSP
        request.setAttribute("listSize", listSize);
        request.setAttribute("listTop5", listTop5);

        // Chuyển hướng đến trang dashboard.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/recruiter/dashboard.jsp");
        dispatcher.forward(request, response);
    }

}
