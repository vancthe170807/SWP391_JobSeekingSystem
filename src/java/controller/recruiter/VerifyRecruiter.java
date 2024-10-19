/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.recruiter;

import constant.CommonConst;
import dao.CompanyDAO;
import dao.RecruitersDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.Company;
import model.JobPostings;
import model.Recruiters;

@WebServlet(name = "VerifyRecruiter", urlPatterns = {"/verifyRecruiter"})
public class VerifyRecruiter extends HttpServlet {

    RecruitersDAO reDAO = new RecruitersDAO();
    CompanyDAO companyDao = new CompanyDAO();  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        //Recruiters recruiters = reDAO.findRecruitersbyAccountID(String.valueOf(account.getId()));
        //List<Company> companies = companyDao.getCompanyNameByAccountId(account.getId());
        List<Company> companies = companyDao.findAll();
        request.setAttribute("companyList", companies);
        request.getRequestDispatcher("view/recruiter/verifyRecruiter.jsp").forward(request, response);
    }    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        //Recruiters recruiters = reDAO.findRecruitersbyAccountID(String.valueOf(account.getId()));
        int companyId = Integer.parseInt(request.getParameter("companyId"));
        String position = request.getParameter("position");
        
        Recruiters re = new Recruiters();
        re.setAccountID(account.getId());
        re.setCompanyID(companyId);
        re.setPosition(position);
        re.setIsVerify(false);
        reDAO.insert(re);
        request.setAttribute("verify", "Your verification request has been sent.");
        request.getRequestDispatcher("view/recruiter/verifyRecruiter.jsp").forward(request, response);
    }
    
}
